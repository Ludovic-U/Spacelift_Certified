class_name Player extends CharacterBody3D

@export var EVA_thruster:float = 10
@export var Walking_Speed:float = 200
var direction:Vector2 = Vector2.ZERO
var MagBoots:bool = true

func _ready():
	Global.player = self

func get_inputs() -> void:
		direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

func _process(delta):
	if Global.game_controller.current_state == Global.game_controller.GameStates.RUNNING:
		get_inputs()
	velocity = Vector3(direction.x, 0, direction.y) * Walking_Speed * delta
	if direction != Vector2.ZERO:
		rotation.y = -direction.angle()
	
	move_and_slide()
