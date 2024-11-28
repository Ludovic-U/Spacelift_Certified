class_name CargoShip extends RigidBody3D

signal collect
@export var collectable_item_class:String

func _on_cargo_area_3d_body_entered(body:PhysicsBody3D) -> void:
	if body.get_script():
		if body.get_script().get_global_name() == collectable_item_class:
			print("collect")
			collect.emit()
			body.queue_free()


func _on_body_entered(body): #TODO: contribute to the doc on how to detect collision  
	if body is SpaceShip:
		print("don't scratch my ship!")
