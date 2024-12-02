class_name Level extends Node3D

@export var GUI:PackedScene
@export var level_end_gui:PackedScene

@export_group("Required children")
@export var camera: OrthogonalCamera
@export var dust: ColorRect
var dust_offset = Vector2.ZERO

@export_group("Level Events")
@export var objectives_linked_list_head:Array[GoalComponant]

#var score: int

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
		
func _on_level_end(success_state:int)-> void:
	Global.game_controller.pause_game()
	Global.current_state = Global.GameStates.MENU
	
	if success_state == 0 || level_end_gui == null: #if fail
		Global.game_controller.swap_scene(
			Global.game_controller.INTERFACE,
			"res://Interface/menu/game_over.tscn"
		)
	else :
		Global.game_controller.swap_scene(
			Global.game_controller.INTERFACE,
			level_end_gui.resource_path
		)
