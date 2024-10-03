extends Area2D
class_name ShipInteriorAreaComponant

@export var SHIP:SpaceShip

func _on_body_exited(body):
	if body is PhysicsBody2D:
		var outside_world = SHIP.get_parent()		
		if outside_world is SubViewport:
			var ouside_world_container:SubViewportContainer = outside_world.get_parent()
			print(body.name, "got reparented to ", ouside_world_container.SHIP.get_parent().name)
			body.call_deferred("reparent", ouside_world_container.SHIP.get_parent())
		else:
			body.call_deferred("reparent", outside_world)
			print(body.name, "got reparented to ", outside_world.name)
			
		body.position = SHIP.to_global(body.position) + $"../..".position.rotated(SHIP.rotation) #VPcontainer
		body.rotation = body.rotation + SHIP.rotation
		if body is RigidBody2D:
			body.linear_velocity = body.linear_velocity.rotated(SHIP.rotation) + SHIP.linear_velocity
