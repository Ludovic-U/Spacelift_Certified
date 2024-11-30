class_name Level extends Node3D

@export var GUI:PackedScene #TODO: move this to GoalComponant
@export_group("Required children")
@export var camera: OrthogonalCamera
@export var dust: ColorRect
var dust_offset = Vector2.ZERO
@export var time: TimeSystem

@export_group("Level Events")
@export var objectives_linked_list_head:Array[GoalComponant]

#var score: int

func _ready() -> void:
	Global.current_level = self
	Global.current_state = Global.GameStates.RUNNING
	
	for goal:GoalComponant in objectives_linked_list_head:
		goal.current_state = GoalComponant.GoalState.ACTIVE
	
	#TODO: connect goalcomponant(primary_goal) failed signal to end the level
	#TODO: connect every primary goal to end_level signal
	
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
		
#TODO: on primary_goal completed signal, check if it's the last to end the level
