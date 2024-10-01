extends Area2D

@export var SHIP_INTERIOR_WORLD:SubViewport
@onready var SHIP:SpaceShip = get_parent()

func _on_body_entered(body):
	if body is PhysicsBody2D && body != SHIP && body.get_parent() != SHIP_INTERIOR_WORLD:
		var VPContainer:SubViewportContainer = SHIP_INTERIOR_WORLD.get_parent()
		body.call_deferred("reparent", SHIP_INTERIOR_WORLD)
		body.set_deferred("position", SHIP.to_local(body.position) - VPContainer.position) #TODO: correct entry_door.gd body.position
		body.rotation = body.rotation - SHIP.rotation
		#if body is RigidBody2D:
			#body.linear_velocity = body.linear_velocity.rotated(SHIP.rotation) - SHIP.linear_velocity.rotated(SHIP.rotation)
