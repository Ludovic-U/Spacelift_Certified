class_name OrthogonalCamera extends Camera3D

@export var min_size:float = 10.0
@export var max_size:float = 100.0
@export var zoom_speed:float = 0.2

func _process(_delta):
	if Input.is_action_just_pressed("Mouse_Wheel_Up") && size > min_size:
		set_size(size - size * zoom_speed)
	if Input.is_action_just_pressed("Mouse_Wheel_Down")  && size < max_size:
		set_size(size + size * zoom_speed)
