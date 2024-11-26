extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _draw():
	var center: Vector2 = Vector2.ZERO
	var start_angle: float = 0.0
	var end_angle: float = 360.0
	var point_count: int = abs(start_angle - end_angle)/2
	var color: Color = Color(1, 1, 1, 0.2)
	var width: float = 1.0
	draw_arc(center, 250, start_angle, deg_to_rad(end_angle), point_count, color, width, false)
