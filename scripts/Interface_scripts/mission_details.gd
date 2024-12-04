class_name MissionDetails extends MarginContainer
@onready var title = $VBoxContainer/HBoxContainer/level_title
@onready var primary = $VBoxContainer/ScrollContainer/VBoxContainer/primary_text
@onready var secondary = $VBoxContainer/ScrollContainer/VBoxContainer/secondary_text
@onready var description = $VBoxContainer/ScrollContainer/VBoxContainer/description_text 

func _ready():
	#TODO make the parsing into a loop
	var m_details:Dictionary = Global.mission_details.details
	if Global.mission_details != null:
		title.text = m_details["Title"]
		primary.text = m_details["Primary"]
		secondary.text = str(m_details["Secondary"])
		description.text = m_details["Description"]
		if m_details["leaderboard_name"]:
			if m_details["leaderboard_name"] != "":
				var new_leaderboard = load("res://Interface/menu/leaderbord.tscn").instantiate()
				$VBoxContainer/ScrollContainer/VBoxContainer.add_child(new_leaderboard)
				new_leaderboard._create_leaderboard(m_details["leaderboard_name"])

func _unhandled_key_input(event):
	if event.is_action_pressed("ui_cancel"):
		accept_event()
		_on_back_button_button_down()

func _on_back_button_button_down(): 
	Global.game_controller.swap_scene(  #swap the right column of game_menu
		self.get_parent(), #TODO: make it more maintainable
		"res://Interface/menu/setting_quit.tscn",
		)
	
	Global.game_controller.swap_scene( #load default intro
		Global.game_controller.WORLD_3D,
		"res://scenes/levels/intro/default_intro.tscn",
		)

func _on_start_mission_button_down():
	Global.game_controller.swap_scene( 
		Global.game_controller.WORLD_3D,
		Global.mission_details.level_path,
		)
		
	Global.game_controller.delete_scene(Global.game_controller.INTERFACE.get_child(0))
	
