class_name Leaderboard extends VBoxContainer

var entry_scene:PackedScene = preload("res://Interface/menu/leaderboard_entry.tscn")

func _create_leaderboard(leaderboard_name:String)-> void:
	await Global.game_controller.get_leaberboard(leaderboard_name, 0)
	
	var entries = Talo.leaderboards.get_cached_entries(leaderboard_name)
	
	if entries.size() == 0:
		$table/Label.text = "No score yet. Be the first to add your score !"
	else:
		$table/Label.queue_free()
		for entry:TaloLeaderboardEntry in entries:
			entry.position = entries.find(entry)
			var highlight:bool = false
			if Global.current_level:
				highlight = "%4.2f" % Global.current_level.score == "%4.2f" % entry.score  && Global.player_name == entry.player_alias.identifier
			_create_entry(entry, highlight)

func _create_entry(entry:TaloLeaderboardEntry, highlight:bool) -> void:
	var entry_instance:Control = entry_scene.instantiate()
	entry_instance._set_data(entry)
	$table.add_child(entry_instance)
	if highlight:
		entry_instance.animation.play("score_highlight")
