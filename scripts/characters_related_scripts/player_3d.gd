class_name Player extends CharacterBody3D

var direction:Vector2 = Vector2.ZERO
@export var EVA_thruster:float = 10
@export var Walking_Speed:float = 200
var MagBoots:bool = true

func _ready():
	Global.player = self

func get_inputs() -> void:
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func _process(delta):
	if Global.current_state == Global.GameStates.RUNNING:
		get_inputs()
	velocity = Vector3(direction.x, 0, direction.y) * Walking_Speed * delta
	if direction != Vector2.ZERO:
		rotation.y = lerp_angle(rotation.y, -direction.angle(), 0.15)
	
	move_and_slide()
