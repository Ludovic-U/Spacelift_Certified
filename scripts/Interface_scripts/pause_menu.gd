extends Control


	
func _unhandled_input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		accept_event()
		Global.current_state = Global.GameStates.RUNNING
		unpause()

func unpause() -> void:
	get_tree().paused = false
	self.queue_free()

func _on_continue_button_down():
	Global.current_state = Global.GameStates.RUNNING
	unpause()

func _on_settings_button_down():
	pass #TODO settings button

func _on_quit_menu_button_down():
	Global.game_controller.swap_scene(
		Global.game_controller.INTERFACE,
		"res://Interface/menu/game_menu.tscn"
	)
	Global.game_controller.swap_scene(
		Global.game_controller.WORLD_3D,
		"res://scenes/levels/intro/default_intro.tscn"
	)	
	Global.current_state = Global.GameStates.MENU
	Global.current_level = null
	unpause()
	

func _on_quit_desktop_button_down():
	Global.game_controller.add_scene(
		Global.game_controller,
		"res://Interface/menu/modal_quit.tscn"
	)
