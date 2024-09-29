extends Camera2D

func _process(_delta):
	if %player != null:
		global_position = %player.global_position
