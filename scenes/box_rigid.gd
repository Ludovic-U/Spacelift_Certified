extends RigidBody2D


func _ready():
	$border.set_modulate(Color (0, 1, 0, 1))
	if freeze :
		$border.set_modulate(Color(1, 0, 0, 1))
	
func _on_magnetize_to_ship_componant_demagnetizing_from_ship():
	$border.set_modulate(Color (0, 1, 0, 1))

func _on_magnetize_to_ship_componant_magnetizing_to_ship(_ship):
	$border.set_modulate(Color(1, 0, 0, 1))
