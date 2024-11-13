class_name GameMenu extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var level_buttons = %Level_selector.get_children()
	for button:LevelButton in level_buttons:
		button.show_mission_details.connect(_on_levelbutton_down)


func _on_levelbutton_down() -> void:
	Global.game_controller.swap_scene(%Right_column, "res://Interface/menu/mission_details.tscn")
