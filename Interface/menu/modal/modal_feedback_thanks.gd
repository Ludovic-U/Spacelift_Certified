extends Control

func _input(event):
	if event.is_action("ui_cancel"):
		self.queue_free()

func _on_close_button_down():
	self.queue_free()
