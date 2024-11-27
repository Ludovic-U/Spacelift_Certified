class_name Level extends Node3D

@export var GUI:PackedScene
@export var camera: OrthogonalCamera
@export var dust: ColorRect
@export var time: TimeSystem
var dust_offset = Vector2.ZERO
var previous_direction = Vector2.ZERO

var score: int

func _ready() -> void:
	Global.current_level = self
	Global.current_state = Global.GameStates.RUNNING
	
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
