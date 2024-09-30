extends Area2D

@export var SHIP_INTERIOR_WORLD:SubViewport
@onready var SHIP:SpaceShip = get_parent()

func _on_body_entered(body):
	if body is PhysicsBody2D && body != SHIP:
		var inside_world = $"../ShipInteriorWorldContainer/ShipInteriorWorld"
		body.call_deferred("reparent", inside_world)
		print(body.position, " entered the ship")
		body.position = body.position - SHIP.position
		body.rotation = body.rotation + SHIP.rotation
		#if body is RigidBody2D:
			#body.linear_velocity = body.linear_velocity.rotated(SHIP.rotation) - SHIP.linear_velocity.rotated(SHIP.rotation)
