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
		
	_push_away_rigid_bodies()
	move_and_slide()
	
func _push_away_rigid_bodies():
	for i in get_slide_collision_count():
		var c := get_slide_collision(i)
		if c.get_collider() is RigidBody3D:
			var push_dir = -c.get_normal()
			# How much velocity the object needs to increase to match player velocity in the push direction
			var velocity_diff_in_push_dir = self.velocity.dot(push_dir) - c.get_collider().linear_velocity.dot(push_dir)
			# Only count velocity towards push dir, away from character
			velocity_diff_in_push_dir = max(0., velocity_diff_in_push_dir)
			# Objects with more mass than us should be harder to push. But doesn't really make sense to push faster than we are going
			const MY_APPROX_MASS_KG = 80.0
			var mass_ratio = min(1., MY_APPROX_MASS_KG / c.get_collider().mass)
			# Optional add: Don't push object at all if it's 4x heavier or more
			if mass_ratio < 0.25:
				continue
			# Don't push object from above/below
			push_dir.y = 0
			# 5.0 is a magic number, adjust to your needs
			var push_force = mass_ratio * 5.0
			c.get_collider().apply_impulse(push_dir * velocity_diff_in_push_dir * push_force, c.get_position() - c.get_collider().global_position)
