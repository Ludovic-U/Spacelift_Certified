extends Node2D
class_name ShipDataComponant
@export var SHIP:SpaceShip 
@onready var radius: float = $ship_orientation_line.points[0].x - 5

#func _ready():
	
	
func _process(_delta):
	global_rotation = 0	
	$ship_orientation_line.global_rotation = SHIP.global_rotation
	if SHIP.linear_velocity == Vector2.ZERO:
		$absolute_velocity_arrow.visible = false
	else:
		$absolute_velocity_arrow.visible = true
		$absolute_velocity_arrow.global_rotation = atan2(SHIP.linear_velocity.y, SHIP.linear_velocity.x)

#func _on_interactible_area_mouse_entered():
	#$absolute_velocity_arrow.visible = true
#
#func _on_interactible_area_mouse_exited():
	#$absolute_velocity_arrow.visible = false

func _draw():
	var center: Vector2 = Vector2.ZERO
	var start_angle: float = 0.0
	var end_angle: float = 360.0
	var point_count: int = abs(start_angle - end_angle)/2
	var color: Color = Color(1, 1, 1, 0.2)
	var width: float = 1.0
	draw_arc(center, radius, start_angle, deg_to_rad(end_angle), point_count, color, width, false)
	
	
