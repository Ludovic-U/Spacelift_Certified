class_name GameController extends Node

@export var WORLD_3D: Node3D
var current_3D_scene_path: String = "res://scenes/levels/intro/default_intro.tscn"
@export var INTERFACE: Control


func _ready() :
	Global.game_controller = self
	

#TODO add transition parametter
#TODO deal with the case when the user click twice on the same button
func change_scene(parent: Node, new_scene: String, delete_parent_child:bool = true, keep_running: bool = false) -> void:
	if current_3D_scene_path == new_scene:
		return
	elif new_scene.begins_with("res://scenes/levels/"): #TODO make this more maintainable
		current_3D_scene_path = new_scene
		
	if parent.get_child_count() != 0:
		var current_parent_child = parent.get_child(0)
		if delete_parent_child :
			current_parent_child.queue_free()
		elif keep_running:
			current_parent_child.visible = false
		else :
			current_parent_child.remove()
			#TODO: save the scene in a variable to be retrieved later.
	
	if new_scene != "":
		var new = load(new_scene).instantiate()
		parent.add_child(new)
		
func _unhandled_input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		match Global.current_state:
			Global.GameStates.RUNNING:
				Global.current_state = Global.GameStates.PAUSED
				get_tree().paused = true
				Engine.time_scale = 0 #TODO find a better way to pause shaders, as it pause every shader in the tree
				
			Global.GameStates.PAUSED: 
				Global.current_state = Global.GameStates.RUNNING
				get_tree().paused = false
				Engine.time_scale = 1
				
				
