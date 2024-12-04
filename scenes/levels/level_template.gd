class_name Level extends Node3D

signal leaderboard_add_entry(lb_name:String, score:int)

@export var GUI:PackedScene
@export var level_end_gui:PackedScene
@export var leaderboard_name:String #TODO: upload to leaderboard componant ?
@export var save_componant:SaveDataComponant
#var score:Array

@export_group("Required children")
@export var camera: OrthogonalCamera
@export var dust: ColorRect
var dust_offset = Vector2.ZERO

@export_group("Level Events")
@export var objectives_linked_list_head:Array[GoalComponant]


func _ready() -> void:
	Global.current_level = self
	Global.current_state = Global.GameStates.RUNNING
	
	for goal:GoalComponant in objectives_linked_list_head:
		goal.activate()
	
	#TODO: connect goalcomponant(primary_goal) failed signal to end the level
	#TODO: connect every primary goal end_level signal to on_level_end()
	
	if GUI != null: #Load GUI
		Global.game_controller.add_scene(
			Global.game_controller.INTERFACE,
			GUI.resource_path
		)
	

func _process(delta):
	if camera.target is RigidBody3D: #Move the star dust background depending on camera velocity
		var object:RigidBody3D = camera.target
		dust_offset += Vector2(object.linear_velocity.x, object.linear_velocity.z) / camera.size * 0.1 * delta #TODO: replace target valocity by camera velocity to make the dust move even without target
		dust.material.set_shader_parameter("offset", dust_offset )
		
func _on_level_end(success_state:int):	
	if success_state == 0 || level_end_gui == null: #if fail
		Global.game_controller.swap_scene(
			Global.game_controller.INTERFACE,
			"res://Interface/menu/game_over.tscn"
		)
		
	else : # if sucess
		save_componant._on_collect_data()
		var score = save_componant.collected_data[0]
		var dictionary = {}
		
		Global.game_controller.leaderboard_add_entry(leaderboard_name, score)
		
		Global.game_controller.swap_scene(
			Global.game_controller.INTERFACE,
			level_end_gui.resource_path
		)
		
	Global.game_controller.pause_game()
	Global.current_state = Global.GameStates.MENU

func get_leaberboard() -> void: #this works when called from ready, not from "on level end"
	var res = await Talo.leaderboards.get_entries(leaderboard_name, 0)
	var _entries = res[0]
	var count = res[1]
	var is_last_page = res[2]

	print("%s entries, is last page: %s" % [count, is_last_page])
