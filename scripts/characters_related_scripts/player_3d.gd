class_name Player extends CharacterBody3D

@export var EVA_thruster:float = 10
@export var Walking_Speed:float = 200
var MagBoots:bool = true

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = Vector3(direction.x, 0, direction.y) * Walking_Speed * delta
	move_and_slide()
