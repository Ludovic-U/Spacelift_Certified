extends CharacterBody2D


const WALKING_SPEED:float = 50.0
var PUSH_FORCE:float = 1.1
var isPiloting: SpaceShip

func _physics_process(_delta):
	var direction:Vector2 = Vector2.ZERO
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * WALKING_SPEED
	move_and_slide()
	
	for i:int in get_slide_collision_count():
		var collided_body:Object = get_slide_collision(i).get_collider()
		if collided_body is RigidBody2D && collided_body.collision_layer == 8:
			collided_body.apply_central_impulse(-get_slide_collision(i).get_normal() * PUSH_FORCE)


func _on_magnetize_to_ship_componant_demagnetizing_from_ship():
	pass # Replace with function body.


func _on_magnetize_to_ship_componant_magnetizing_to_ship(ship:SpaceShip):
	$Camera2D.global_position = ship.global_position
