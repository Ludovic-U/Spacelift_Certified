extends MarginContainer


func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_quit_button_down():
	get_tree().quit()

func _on_settings_button_down():
	pass # TODO: settings UI
