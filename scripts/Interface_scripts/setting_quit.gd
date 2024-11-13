extends MarginContainer


func _unhandled_input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		Global.game_controller.add_scene(
			Global.game_controller, 
			"res://Interface/menu/modal_quit.tscn"
			)

func _on_quit_button_down():
	Global.game_controller.add_scene(
			Global.game_controller.INTERFACE, 
			"res://Interface/menu/modal_quit.tscn"
			)

func _on_settings_button_down():
	pass # TODO: settings UI
