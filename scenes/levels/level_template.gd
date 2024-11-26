class_name Level extends Node3D

@export var camera: OrthogonalCamera
@export var dust: ColorRect

func _process(delta):
	if camera.target is RigidBody3D:
		var object:RigidBody3D = camera.target
		dust.material.set_shader_parameter("direction", 
		Vector2(-object.linear_velocity.x, -object.linear_velocity.z) / (camera.size * 3)
		)
