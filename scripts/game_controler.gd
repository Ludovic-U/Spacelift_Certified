class_name GameController extends Node

@export var WORLD_3D: Node3D
@export var INTERFACE: Control

func _ready() :
	Global.game_controller = self

#TODO add transition parametter
#TODO deal with the case when the user click twice on the same button
func change_scene(parent: Node, new_scene: String, delete_parent_child:bool = true, keep_running: bool = false) -> void:
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
		
		
