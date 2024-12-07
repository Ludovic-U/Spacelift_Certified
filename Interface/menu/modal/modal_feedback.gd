extends Control

func _input(event):
	if event.is_action("ui_cancel"):
		self.queue_free()

func _on_close_button_down():
	self.queue_free()

func _on_send_button_down():
	await Talo.players.identify("username", Global.player_name)
	await Talo.feedback.send(%category.get_item_text(%category.selected), %TextEdit.text)
	
	Global.game_controller.add_scene(
		Global.game_controller,
		"res://Interface/menu/modal/modal_feedback_thanks.tscn"
	)
	
	self.queue_free()
	
