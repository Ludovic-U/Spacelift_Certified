extends Node2D
class_name MagnetizeToShipComponant

@onready var PARENT:PhysicsBody2D = get_parent()
@onready var SPACE:Node2D = get_tree().root.get_child(0)
@onready var REPARENTING:RigidBody2D = null

signal magnetizing_to_ship
signal demagnetizing_from_ship

#updatable by ShipInteriorAreaComponant
var IsInside:Array[RigidBody2D]

func magnetize_to_closest_ship():
	#TODO: magnetize_to_closest_ship()
	print("TODO: magnetize to closest ship", IsInside)

#Called by ShipInteriorAreaComponant (NOT ANYMORE - CURRENTLY NOT CALLED BY ANYTHING)
func toggle_magnetize_to_ship_state(new_ship):
	if PARENT is RigidBody2D:
		if PARENT.freeze:
			demagnetizing_from_ship.emit()
			PARENT.call_deferred("reparent", SPACE)
			PARENT.freeze = false
		else:
			magnetizing_to_ship.emit(new_ship)
			PARENT.freeze = true
			PARENT.call_deferred("reparent", new_ship)
			
	if PARENT is CharacterBody2D:
		var prev_ship = PARENT.get_parent()
		if prev_ship != SPACE:
			if IsInside.size() > 0:
				magnetize_to_closest_ship()
				return
			PARENT.call_deferred("reparent", SPACE)
		elif prev_ship != new_ship :
			REPARENTING = new_ship
			PARENT.call_deferred("reparent", new_ship)
