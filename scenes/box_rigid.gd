extends RigidBody2D


func _ready():
	$border.set_modulate(Color (0, 1, 0, 1))
	if freeze :
		$border.set_modulate(Color(1, 0, 0, 1))
		
#func _process(_delta):
	#print(PhysicsServer2D.body_get_state(self.get_rid(), PhysicsServer2D.BODY_STATE_TRANSFORM))
	
func _on_magnetize_to_ship_componant_demagnetizing_from_ship():
	$border.set_modulate(Color (0, 1, 0, 1))

func _on_magnetize_to_ship_componant_magnetizing_to_ship(_ship):
	$border.set_modulate(Color(1, 0, 0, 1))
