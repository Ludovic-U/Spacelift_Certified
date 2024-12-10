class_name GameController extends Node

@export var WORLD_3D: Node3D
var current_3D_scene_path: String = "res://scenes/levels/intro/default_intro.tscn"
@export var INTERFACE: Control


func _ready() :
	Global.game_controller = self	
	
	
func pause_game():
	get_tree().paused = true
	Global.current_state = Global.GameStates.PAUSED

func unpause_game():
	get_tree().paused = false
	# the main menu is unpaused, so state is either running or menu

	
func leaderboard_add_entry(leaderboard_name:String, score:float, additional_properties:Dictionary)->void:
	await Talo.players.identify("username", Global.player_name)
	await Talo.leaderboards.add_entry(leaderboard_name, score, additional_properties)
	print("entry succesfuly added to leaderboard: ", leaderboard_name)
	
func get_leaberboard(leaderboard_name:String, page:int = 0) -> void:
	await Talo.players.identify("username", Global.player_name)
	await Talo.leaderboards.get_entries(leaderboard_name, page)
	
#TODO add transition parametter
func swap_scene(parent: Node, new_scene_path: String, delete_parent_children:bool = true, keep_running: bool = false, _transition:Global.Transitions = Global.Transitions.NONE) -> void:
	if current_3D_scene_path == new_scene_path:
		return
	elif new_scene_path.begins_with("res://scenes/levels/"): #TODO make this more maintainable
		current_3D_scene_path = new_scene_path
		
	if parent.get_child_count() != 0:
		var current_parent_children = parent.get_children()
		for child in current_parent_children:
			if delete_parent_children :
				child.queue_free()
			elif keep_running:
				child.visible = false
			else :
				child.remove()
				#TODO: save the scene in a variable to be retrieved later.
	
	if new_scene_path != "":
		var new_scene = load(new_scene_path).instantiate()		
		parent.add_child(new_scene)
		

# TODO add transition parameter
func add_scene(parent: Node, new_scene: String, _transition:Global.Transitions = Global.Transitions.NONE) -> void:
	if new_scene != "":
		var new = load(new_scene).instantiate()
		parent.add_child(new)
		
func delete_scene(scene:Node, _transition:Global.Transitions = Global.Transitions.NONE) -> void:
	scene.queue_free()
	
func restart_level():
	Global.goal_list_ui.clear()
	#TODO: Talo stat
	swap_scene(INTERFACE, "")
	var new_level:Level = load(Global.current_level.scene_file_path).instantiate()
	WORLD_3D.get_child(0).free() #TODO: WARNING potentialy unsafe. free is called instead of queue_free because otherwise current_level children are not deleted soon enough and cause problem when the new level scripts are triggered
	WORLD_3D.call_deferred("add_child", new_level)
	
	unpause_game()
	Global.current_state = Global.GameStates.RUNNING
	Global.current_level = new_level

func _unhandled_input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		match Global.current_state:
			Global.GameStates.RUNNING:
				Global.current_state = Global.GameStates.PAUSED
				pause_game()
				#Engine.time_scale = 0 #TODO find a better way to pause shaders, as it pause every shader in the tree
				
				Global.game_controller.add_scene(
					Global.game_controller.INTERFACE,
					"res://Interface/menu/pause_menu.tscn"
				)
