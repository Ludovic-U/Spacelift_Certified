extends Node2D

@onready var radius: float = $"../ship_orientation_line".points[0].x - 5
@onready var SHIP: SpaceShip = $"..".SHIP

func inertia_value(): #TODO: call inertia_value only once
	return 1.0 / PhysicsServer2D.body_get_direct_state(SHIP.get_rid()).inverse_inertia


func _process(_delta):
	queue_redraw()
	print(SHIP.linear_velocity)
	
#func _physics_process(delta):
	#print(SHIP.angular_velocity / delta)
	

func _draw():
	var center: Vector2 = Vector2.ZERO
	var start_angle: float = rad_to_deg(SHIP.global_rotation)
	var time_to_stop = abs(SHIP.angular_velocity / (SHIP.spin_thrust / inertia_value())) if SHIP.spin_thrust != 0 else 0
	var end_angle: float = rad_to_deg(SHIP.global_rotation + (0.5 * SHIP.angular_velocity * time_to_stop)) 
	var point_count: int = abs(start_angle - end_angle) * 3
	var color: Color = Color(1, 1, 1, 1)
	var width: float = 1.0
	if SHIP.angular_velocity != null && point_count >= 2:
		draw_arc(center, radius, deg_to_rad(start_angle), deg_to_rad(end_angle), point_count, color, width, true)
