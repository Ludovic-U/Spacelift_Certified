extends Control

func _unhandled_input(event:InputEvent):
	if event.is_action_pressed("ui_cancel"):
		accept_event()
		self.queue_free()
	if event.is_action_pressed("ui_accept"):
		get_tree().quit()

func _on_crossbtn_button_down():
	self.queue_free()

func _on_cancelbtn_button_down():
	self.queue_free()

func _on_quitbtn_button_down():
	get_tree().quit()
