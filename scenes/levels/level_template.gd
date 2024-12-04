class_name Level extends Node3D

@export var GUI:PackedScene
@export var level_end_gui:PackedScene
@export var leaderboard_name:String #TODO: upload to leaderboard componant ?
@export var save_componant:SaveDataComponant
#var score:Array

@export_group("Required children")
@export var camera: OrthogonalCamera
@export var dust: ColorRect
var dust_offset = Vector2.ZERO

@export_group("Level Events")
@export var objectives_linked_list_head:Array[GoalComponant]


func _ready() -> void:
	Global.current_level = self
	Global.current_state = Global.GameStates.RUNNING
	
	for goal:GoalComponant in objectives_linked_list_head:
		goal.activate()
	
	for goal:GoalComponant in objectives_linked_list_head:
		connect_primary_goals_fail_signal(goal)
	
	if GUI != null: #Load GUI
		Global.game_controller.add_scene(
			Global.game_controller.INTERFACE,
			GUI.resource_path
		)
func connect_primary_goals_fail_signal(goal:GoalComponant)->void:
	if goal.priority == "Primary":
		goal.end_level.connect(_on_level_end)
	if goal.next_goals.is_empty():
		return
	else:
		for next_goal:GoalComponant in goal.next_goals:
			connect_primary_goals_fail_signal(next_goal)

func _process(delta):
	if camera.target is RigidBody3D: #Move the star dust background depending on camera velocity
		var object:RigidBody3D = camera.target
		dust_offset += Vector2(object.linear_velocity.x, object.linear_velocity.z) / camera.size * 0.1 * delta #TODO: replace target valocity by camera velocity to make the dust move even without target
		dust.material.set_shader_parameter("offset", dust_offset )
		
func _on_level_end(success_state:bool):	
	if success_state == false || level_end_gui == null: #if fail
		Global.game_controller.swap_scene(
			Global.game_controller.INTERFACE,
			"res://Interface/menu/game_over.tscn"
		)
		
	else : # if sucess
		if leaderboard_name != "":
			save_componant._on_collect_data()
			var score:float = save_componant.collected_data[0]
			var additionnal_properties:Dictionary = {}
			Global.game_controller.leaderboard_add_entry(leaderboard_name, score, additionnal_properties)
		
		Global.game_controller.swap_scene(
			Global.game_controller.INTERFACE,
			level_end_gui.resource_path
		)
		
	Global.game_controller.pause_game()
	Global.current_state = Global.GameStates.MENU
