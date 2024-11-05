class_name LevelButton extends Button

@export var intro: String = "res://scenes/levels/default_intro.tscn"
@export var level: String 
@export var details: Dictionary = {
	"Title":"Test Level",
	"Primary":"Objective one",
	"Secondary":["Objective two", "Objective three"],
	"Description":"Some context",	
}

signal show_mission_details

func _on_button_down() -> void:
	Global.mission_details = self
	Global.game_controller.change_scene(Global.game_controller.WORLD_3D, intro, true, false)
	show_mission_details.emit()
