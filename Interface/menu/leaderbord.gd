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
			_create_entry(entry)

func _create_entry(entry:TaloLeaderboardEntry) -> void:
	var entry_instance = entry_scene.instantiate()
	entry_instance._set_data(entry)
	$table.add_child(entry_instance)
