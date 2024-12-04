class_name Leaderboard extends Control

var entry_scene:PackedScene = preload("res://Interface/menu/leaderboard_entry.tscn")

func _create_leaderboard(name:String)-> void:
	await Global.game_controller.get_leaberboard(name, 0)
	var entries = Talo.leaderboards.get_cached_entries(name)
	
	for entry:TaloLeaderboardEntry in entries:
		entry.position = entries.find(entry)
		_create_entry(entry)

func _create_entry(entry:TaloLeaderboardEntry) -> void:
	var entry_instance = entry_scene.instantiate()
	entry_instance._set_data(entry)
	$table.add_child(entry_instance)
