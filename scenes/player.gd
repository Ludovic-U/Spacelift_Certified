extends CharacterBody2D
class_name Player


const WALKING_SPEED:float = 50.0
var PUSH_FORCE:float = 1.1
var isPiloting: SpaceShip
@onready var CAMERA:Camera2D = get_tree().current_scene.find_child("Camera2D")	

func _physics_process(_delta):
	print(CAMERA.name, CAMERA.position)
	var direction:Vector2 = Vector2.ZERO
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction.rotated(CAMERA.rotation) * WALKING_SPEED
	move_and_slide()
	
	for i:int in get_slide_collision_count():
		var collided_body:Object = get_slide_collision(i).get_collider()
		if collided_body is RigidBody2D && collided_body.collision_layer == 8: #push only small rigidbodies
			collided_body.apply_central_impulse(-get_slide_collision(i).get_normal() * PUSH_FORCE)


func _on_magnetize_to_ship_componant_demagnetizing_from_ship():
	pass


func _on_magnetize_to_ship_componant_magnetizing_to_ship(ship:SpaceShip):
	pass
