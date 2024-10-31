extends CharacterBody3D

class_name Player

@export var EVA_thruster:float = 10
@export var Walking_Speed:float = 200
var MagBoots = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var direction:Vector2 = Vector2.ZERO
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#apply_central_force(Vector3(direction.x, 0, direction.y) * EVA_thruster)
	velocity = Vector3(direction.x, 0, direction.y) * Walking_Speed * delta
	move_and_slide()
