extends Control

func _unhandled_input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		accept_event()
		Global.current_state = Global.GameStates.RUNNING
		Global.game_controller.unpause_game()
		self.queue_free()


func _on_continue_button_down():
	Global.current_state = Global.GameStates.RUNNING
	Global.game_controller.unpause_game()
	self.queue_free()

func _on_settings_button_down():
	pass #TODO settings button
	

func _on_quit_desktop_button_down():
	Global.game_controller.add_scene(
		Global.game_controller,
		"res://Interface/menu/modal_quit.tscn"
	)
