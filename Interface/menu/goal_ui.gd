extends PanelContainer

func _on_goal_update() -> void :
	$Update_Animation.play("update")
	$AudioStreamPlayer.play()
