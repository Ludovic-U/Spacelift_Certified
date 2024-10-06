extends Area2D

@export var SHIP_INTERIOR_WORLD:SubViewport
@export var SHIP:SpaceShip = get_parent()

func _on_body_entered(body):
	if body is PhysicsBody2D && body != SHIP && body.get_parent() != SHIP_INTERIOR_WORLD:
		var VPContainer:SubViewportContainer = SHIP_INTERIOR_WORLD.get_parent()
		if body is SpaceShip:
			body.isReparenting = true
		if SHIP.get_parent() is SubViewport:
			SHIP.get_parent().find_child("ShipInteriorAreaComponant").ignoreExitingBody = body
		body.get_parent().remove_child(body)
		SHIP_INTERIOR_WORLD.call_deferred("add_child", body)
		
		body.set_deferred("position", SHIP.to_local(body.position) - VPContainer.position)
		body.set_deferred("isReparenting", false)
		print("entry door: ", body.name, " got reparented to ", SHIP.name)
		body.rotation = body.rotation - SHIP.rotation
		if body is RigidBody2D:
			body.linear_velocity = body.linear_velocity.rotated(SHIP.rotation) - SHIP.linear_velocity.rotated(SHIP.rotation)
