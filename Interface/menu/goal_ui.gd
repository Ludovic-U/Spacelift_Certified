extends PanelContainer

func _on_goal_update() -> void :
	$Update_Animation.play("update")	
	$goal_update.play()
	
func move_to_last() -> void:
	if get_parent():
		get_parent().move_child(self, -1)
		$new_goal.play()
