extends Camera2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if %player != null:
		global_position = %player.global_position
