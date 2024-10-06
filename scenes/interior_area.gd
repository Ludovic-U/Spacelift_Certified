extends Area2D
class_name ShipInteriorAreaComponant

@export var SHIP:SpaceShip

var ignoreExitingBody:PhysicsBody2D

func _on_body_exited(body):
	if body == ignoreExitingBody:
		ignoreExitingBody = null
	elif body is PhysicsBody2D && !SHIP.isReparenting:
		var outside_world = SHIP.get_parent()
		if body is SpaceShip:
			body.isReparenting = true
		body.call_deferred("reparent", outside_world)
		body.set_deferred("isReparenting", false)
		print("ship interior: ", body.name, " gor reparented to ", outside_world.name)
		body.position = SHIP.to_global(body.position) + $"../..".position.rotated(SHIP.rotation) #VPcontainer
		body.rotation = body.rotation + SHIP.rotation
		if body is RigidBody2D:
			body.linear_velocity = body.linear_velocity.rotated(SHIP.rotation) + SHIP.linear_velocity
