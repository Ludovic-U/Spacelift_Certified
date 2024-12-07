extends Button



func _on_button_down():
	Global.game_controller.add_scene(
		Global.game_controller,
		"res://Interface/menu/modal/modal_feedback.tscn"
	)
	
	self.release_focus()
