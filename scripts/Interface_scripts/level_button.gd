class_name LevelButton extends Button

@export var intro_path: String = "res://scenes/levels/intro/default_intro.tscn"
@export var level_path: String
@export var leaderboard_name: String 
@export var details: Dictionary = {
	"Title":"Test Level",
	"Primary":"Objective one",
	"Secondary":["Objective two", "Objective three"],
	"Description":"Some context",
}

signal show_mission_details

func _on_button_down() -> void:
	Global.mission_details = self
	Global.game_controller.swap_scene(
		Global.game_controller.WORLD_3D,
		intro_path)
	show_mission_details.emit()
