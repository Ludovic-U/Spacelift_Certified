class_name MissionDetails extends MarginContainer
@onready var title = $VBoxContainer/HBoxContainer/level_title
@onready var primary = $VBoxContainer/ScrollContainer/VBoxContainer/primary_text
@onready var secondary = $VBoxContainer/ScrollContainer/VBoxContainer/secondary_text
@onready var description = $VBoxContainer/ScrollContainer/VBoxContainer/description_text 

func _ready():
	#TODO make the parsing into a loop
	if Global.mission_details != null:
		title.text = Global.mission_details.details["Title"]
		primary.text = Global.mission_details.details["Primary"]
		secondary.text = str(Global.mission_details.details["Secondary"])
		description.text = Global.mission_details.details["Description"]

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_back_button_button_down()

func _on_back_button_button_down(): 
	Global.game_controller.change_scene( 
		self.get_parent(),
		"res://Interface/menu/setting_quit.tscn",
		true, false)
	
	Global.game_controller.change_scene( #load default intro
		Global.game_controller.WORLD_3D,
		"res://scenes/levels/intro/default_intro.tscn",
		true, false)


func _on_start_mission_button_down():
	Global.current_state = Global.GameStates.RUNNING
	
	Global.game_controller.change_scene( 
		Global.game_controller.WORLD_3D,
		Global.mission_details.level,
		true, false)
		
	Global.game_controller.change_scene( 
		Global.game_controller.INTERFACE,
		"", #TODO load the right UI
		true, false)
