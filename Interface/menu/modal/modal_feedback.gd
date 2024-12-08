extends Control

func _input(event):
	if event.is_action("ui_cancel"):
		self.queue_free()

func _on_close_button_down():
	self.queue_free()

func _on_send_button_down():
	var str_curr_lvl:String = ""
	if Global.current_level:
		str_curr_lvl = "current level:" + str(Global.current_level.get_path()).get_file() + "| "
	str_curr_lvl += %TextEdit.text
	
	var str_category:String = %category.get_item_text(%category.selected).replace(" ", "_")
	await Talo.players.identify("username", Global.player_name)
	await Talo.feedback.send(str_category, str_curr_lvl)
	
	Global.game_controller.add_scene(
		Global.game_controller,
		"res://Interface/menu/modal/modal_feedback_thanks.tscn"
	)
	
	self.queue_free()
	
