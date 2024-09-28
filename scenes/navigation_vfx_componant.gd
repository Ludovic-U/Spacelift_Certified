extends Node2D
class_name NavigationVFXComponant

@export var SHIP:SpaceShip
@export var Forward_Engine:Array[Sprite2D]
@export var Backward_RCS:Array[Sprite2D]
@export var Transverse_Left_RCS:Array[Sprite2D]
@export var Transverse_Right_RCS:Array[Sprite2D]
@export var Yaw_Right_RCS:Array[Sprite2D]
@export var Yaw_Left_RCS:Array[Sprite2D]


func _process(_delta):
#	TODO: scale the vfx depending on the thrust 
	for thruster:Sprite2D in get_children():
		thruster.visible = false
		if SHIP.thrust.x > 0 && Forward_Engine.has(thruster):
			thruster.visible = true
		if SHIP.thrust.x < 0 && Backward_RCS.has(thruster):
			thruster.visible = true
		if SHIP.thrust.y > 0 && Transverse_Left_RCS.has(thruster):
			thruster.visible = true
		if SHIP.thrust.y < 0 && Transverse_Right_RCS.has(thruster):
			thruster.visible = true
		if SHIP.rotation_dir < 0 && Yaw_Left_RCS.has(thruster):
			thruster.visible = true
		if SHIP.rotation_dir > 0 && Yaw_Right_RCS.has(thruster):
			thruster.visible = true
		
	
