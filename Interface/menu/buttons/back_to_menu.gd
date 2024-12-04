extends Button

func _on_button_down():
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
	Global.game_controller.unpause_game()
