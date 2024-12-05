extends PanelContainer

func _set_data(entry:TaloLeaderboardEntry) -> void:
	$MarginContainer/HBoxContainer/pos.text = str(entry.position +1 )
	$MarginContainer/HBoxContainer/name.text = str(entry.player_alias.identifier)
	$MarginContainer/HBoxContainer/score.text = "%04.2f" % entry.score
	
	match entry.position:
		0: 
			$MarginContainer/HBoxContainer/pos.modulate = Color(7.027, 7.027, 0)
			$MarginContainer/HBoxContainer/name.modulate = Color(7.027, 7.027, 0)
			$MarginContainer/HBoxContainer/score.modulate = Color(7.027, 7.027, 0)
			
		1: 
			$MarginContainer/HBoxContainer/pos.modulate = Color(0.632, 0.837, 1)
			$MarginContainer/HBoxContainer/name.modulate = Color(0.632, 0.837, 1)
			$MarginContainer/HBoxContainer/score.modulate = Color(0.632, 0.837, 1)
			
		2: 
			$MarginContainer/HBoxContainer/pos.modulate = Color(0.847, 0.446, 0.371)
			$MarginContainer/HBoxContainer/name.modulate = Color(0.847, 0.446, 0.371)
			$MarginContainer/HBoxContainer/score.modulate = Color(0.847, 0.446, 0.371)
			
