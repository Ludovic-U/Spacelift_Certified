class_name GameMenu extends HBoxContainer

func _ready():
	var level_buttons = %Level_selector.get_children()
	for button:LevelButton in level_buttons:
		button.show_mission_details.connect(_on_levelbutton_down)
	
	if Global.player_name != "___":
		$Left_column/MarginContainer/Main_menu/entername/LineEdit.text = Global.player_name

func _on_levelbutton_down() -> void:
	Global.game_controller.swap_scene(
		%Right_column,
		"res://Interface/menu/mission_details.tscn")


func _on_line_edit_text_change_rejected(_rejected_substring)-> void:
	%rejected_strin_animation.play("rejected string")


func _on_line_edit_text_changed(new_text)-> void:
	Global.player_name = str(new_text).lstrip(" ").rstrip(" ")
	if Global.player_name == "":
		$Left_column/MarginContainer/Main_menu/entername/LineEdit.text = ""
		Global.player_name = "___"
