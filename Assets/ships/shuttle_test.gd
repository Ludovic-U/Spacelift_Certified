class_name CargoShip extends RigidBody3D

func _on_cargo_area_3d_body_entered(body) -> void:
	if body is Crate:
		print("goal !")
		body.queue_free()


func _on_body_entered(body): #TODO: contribute to the doc on how to detect collision  
	if body is SpaceShip:
		print("don't scratch my ship!")
