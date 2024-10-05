extends RigidBody2D
class_name SpaceShip

@export var engine_thrust:int = 500
@export var rcs_backward_thrust:int = 300
@export var rcs_side_thrust:int = 300
@export var spin_thrust:int = 20000
@export var minimum_speed:int = 5
@export var listen_to_inputs = false

var thrust:Vector2
var rotation_dir:int = 0
var ship_inventory:Array[Node2D]

func get_input():
	#Longitudinal controles
	if Input.is_action_pressed("W_key"):
		thrust = Vector2(engine_thrust, 0)
	elif Input.is_action_pressed("S_key"):
		thrust = Vector2(rcs_backward_thrust * -1, 0)
	else:
		thrust = Vector2()
	
	#Lateral controles
	if Input.is_action_pressed("E_key"):
		thrust = Vector2(thrust.x, rcs_side_thrust)
	elif Input.is_action_pressed("Q_key"):
		thrust = Vector2(thrust.x, rcs_side_thrust * -1)
	else:
		thrust = Vector2(thrust.x, 0)	
	
	rotation_dir = 0
	if Input.is_action_pressed("D_key"):
		rotation_dir += 1
	if Input.is_action_pressed("A_key"):
		rotation_dir -= 1
	if Input.is_action_pressed("X_key"):
		var rotated_velocity:Vector2 = linear_velocity.rotated(-rotation)
		if abs(rotated_velocity.x) > minimum_speed:
			thrust.x = sign(rotated_velocity.x) * -engine_thrust
		if abs(rotated_velocity.y) > minimum_speed:
			thrust.y = sign(rotated_velocity.y) * -rcs_side_thrust

func _process(_delta):
	if listen_to_inputs:
		get_input()
	#TODO: repair the magnetizing plate
	#TODO: move "phantom" collisionshapes representing physic bodies in the inside world
	#if Input.is_action_just_pressed("ui_accept"):
		#ship_inventory= $ShipInteriorArea.get_overlapping_bodies()
		#for body in ship_inventory:
			#if body is RigidBody2D && body.has_node("MagnetizeToShipComponant"):
				#body.get_node("MagnetizeToShipComponant").toggle_magnetize_to_ship_state(self)

func _integrate_forces(state):
	apply_central_force(thrust.rotated(rotation))
	apply_torque(rotation_dir * spin_thrust)
	
	if abs(angular_velocity) < 0.1 && abs(angular_velocity) != 0 && rotation_dir == 0:
		state.angular_velocity = 0
		
	if abs(linear_velocity.x) < minimum_speed && thrust == Vector2.ZERO:
		state.linear_velocity.x = 0
		
	if abs(linear_velocity.y) < minimum_speed && thrust == Vector2.ZERO:
		state.linear_velocity.y = 0
		
