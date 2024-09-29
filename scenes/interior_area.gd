extends Area2D
class_name ShipInteriorAreaComponant

@export var SHIP:SpaceShip
@export var SHIP_INTERIOR:SubViewport


#func _on_body_entered(body):
	#if body.has_node("MagnetizeToShipComponant"):
		#var MagComponant: MagnetizeToShipComponant = body.get_node("MagnetizeToShipComponant")
		#MagComponant.IsInside.append(SHIP)
		#if body is CharacterBody2D:
			#MagComponant.toggle_magnetize_to_ship_state(SHIP)
			

func _on_body_exited(body):
	if body is PhysicsBody2D:
		var outside_world = SHIP.get_parent()		
		if outside_world is SubViewport:
			print(body.name, "got reparented to ", outside_world.SHIP.get_parent().name)
			body.call_deferred("reparent", outside_world.SHIP.get_parent())
		else:
			body.call_deferred("reparent", outside_world)
			
		body.position = SHIP.to_global(body.position) + $"../..".position.rotated(SHIP.rotation)
		body.rotation = body.rotation + SHIP.rotation
		if body is RigidBody2D:
			body.linear_velocity = body.linear_velocity.rotated(SHIP.rotation) + SHIP.linear_velocity
			
