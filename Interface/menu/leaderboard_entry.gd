extends PanelContainer

func _set_data(entry:TaloLeaderboardEntry) -> void:
	$MarginContainer/HBoxContainer/pos.text = str(entry.position +1 )
	$MarginContainer/HBoxContainer/name.text = str(entry.player_alias.identifier)
	$MarginContainer/HBoxContainer/score.text = "%04.2f" % entry.score
	
	match entry.position:
		0: $MarginContainer/HBoxContainer/pos.modulate = Color(7.027, 7.027, 0)
		1: $MarginContainer/HBoxContainer/pos.modulate = Color(0.632, 0.837, 1)
		2: $MarginContainer/HBoxContainer/pos.modulate = Color(0.93, 0.787, 0.731)
