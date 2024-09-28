extends Area2D
class_name ShipInteriorAreaComponant

@export var SHIP:SpaceShip

func _on_body_entered(body):
	if body.has_node("MagnetizeToShipComponant"):
		var MagComponant: MagnetizeToShipComponant = body.get_node("MagnetizeToShipComponant")
		MagComponant.IsInside.append(SHIP)
		if body is CharacterBody2D:
			MagComponant.toggle_magnetize_to_ship_state(SHIP)
			

func _on_body_exited(body):
	if body.has_node("MagnetizeToShipComponant"):
		var MagComponant: MagnetizeToShipComponant = body.get_node("MagnetizeToShipComponant")
		MagComponant.IsInside.erase(SHIP)
		if body is CharacterBody2D:
			MagComponant.toggle_magnetize_to_ship_state(SHIP)
