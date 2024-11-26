extends RigidBody3D
class_name SpaceShip

@export_group("Spaceship Properties")
@export var engine_thrust:int = 2500
@export var rcs_backward_thrust:int = 2500
@export var rcs_side_thrust:int = 2500
@export var spin_thrust:int = 2500
@export var minimum_speed:int = 5
@export var listen_to_inputs = false

@export_group("Thrusters VFX")
@export var Forward_Engine:Array[Sprite3D]
@export var Backward_RCS:Array[Sprite3D]
@export var Transverse_Left_RCS:Array[Sprite3D]
@export var Transverse_Right_RCS:Array[Sprite3D]
@export var Yaw_Right_RCS:Array[Sprite3D]
@export var Yaw_Left_RCS:Array[Sprite3D]


var isReparenting:bool = false
var thrust:Vector3
var rotation_dir:int = 0
var ship_inventory:Array[Node2D]

#@onready var sun:DirectionalLight2D = self.find_child("Sun", true, true)

func _process(_delta):
	if Global.current_state == Global.GameStates.RUNNING && listen_to_inputs:
		get_input()
	
	fire_thrusters()
	
	#if sun:
		#sun.rotation = -self.global_rotation
	#TODO: repair the magnetizing plate
	#TODO: move "phantom" collisionshapes representing physic bodies in the inside world
	#if Input.is_action_just_pressed("ui_accept"):
		#ship_inventory= $ShipInteriorArea.get_overlapping_bodies()
		#for body in ship_inventory:
			#if body is RigidBody2D && body.has_node("MagnetizeToShipComponant"):
				#body.get_node("MagnetizeToShipComponant").toggle_magnetize_to_ship_state(self)
				
func get_input():
	#Longitudinal controles
	if Input.is_action_pressed("W_key"):
		thrust = Vector3(engine_thrust, 0, 0)
	elif Input.is_action_pressed("S_key"):
		thrust = Vector3(rcs_backward_thrust * -1, 0, 0)
	else:
		thrust = Vector3()
	
	#Lateral controles
	if Input.is_action_pressed("E_key"):
		thrust = Vector3(thrust.x, 0, rcs_side_thrust)
	elif Input.is_action_pressed("Q_key"):
		thrust = Vector3(thrust.x, 0, rcs_side_thrust * -1)
	else:
		thrust = Vector3(thrust.x, 0, 0)	
	
	rotation_dir = 0
	if Input.is_action_pressed("D_key"):
		rotation_dir -= 1
	if Input.is_action_pressed("A_key"):
		rotation_dir += 1
	if Input.is_action_pressed("X_key"):
		var rotated_velocity:Vector3 = linear_velocity.rotated(Vector3(0, 1, 0),  -rotation.y)
		if abs(rotated_velocity.x) > minimum_speed:
			thrust.x = sign(rotated_velocity.x) * -engine_thrust
		if abs(rotated_velocity.y) > minimum_speed:
			thrust.y = sign(rotated_velocity.y) * -rcs_side_thrust

func _integrate_forces(state):
	apply_central_force(thrust.rotated(Vector3(0, 1, 0), rotation.y))
	apply_torque(Vector3(0, rotation_dir * spin_thrust, 0))
	#TODO: apply forces to bodies inside the ship
	
	if abs(angular_velocity.y) < 0.1 && abs(angular_velocity.y) != 0 && rotation_dir == 0:
		state.angular_velocity.y = 0
		
	#if abs(linear_velocity.x) < minimum_speed && thrust == Vector3.ZERO:
		#state.linear_velocity.x = 0
		#
	#if abs(linear_velocity.y) < minimum_speed && thrust == Vector3.ZERO:
		#state.linear_velocity.y = 0

func fire_thrusters() -> void:
	#TODO: scale the vfx depending on the thrust 
	for thruster:Sprite3D in $ThrusterVFX.get_children():
		thruster.visible = false
		if thrust.x > 0 && Forward_Engine.has(thruster):
			thruster.visible = true
		if thrust.x < 0 && Backward_RCS.has(thruster):
			thruster.visible = true
		if thrust.z < 0 && Transverse_Left_RCS.has(thruster):
			thruster.visible = true
		if thrust.z > 0 && Transverse_Right_RCS.has(thruster):
			thruster.visible = true
		if rotation_dir < 0 && Yaw_Left_RCS.has(thruster):
			thruster.visible = true
		if rotation_dir > 0 && Yaw_Right_RCS.has(thruster):
			thruster.visible = true
