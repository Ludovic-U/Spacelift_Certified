class_name GoalComponant extends Node

signal end_level(success_state:bool) #1 for sucess, 0 for fail
signal completed
signal failed
signal goal_started

enum GoalState {INACTIVE, ACTIVE, COMPLETED, FAILED}
var current_state: GoalState = GoalState.INACTIVE
@export_enum("Primary", "Secondary") var priority: String = "Primary"
@export var next_goals: Array[GoalComponant]
@export var intro_cutscene:AnimationPlayer
@export_group("UI")
@export var hidden:bool = false
@export var description: String = "Do this"
var UI_node:Control
var UI_node_data:RichTextLabel


func _ready():
	if !hidden:
		UI_node = load("res://Interface/menu/Goal_UI.tscn").instantiate()
		UI_node.visible = false
		Global.goal_list_ui.append(UI_node)
		UI_node_data = UI_node.find_child("Data")
		
		for child in get_children():
			if child.has_signal("update"):
				child.update.connect(UI_node._on_goal_update)
	#TODO: Intro
	
func _process(_delta):
	if !hidden && current_state == GoalState.ACTIVE && Global.current_state == Global.GameStates.RUNNING:
		display_progress()
			
func display_progress() -> void:
	if !hidden:
		var progress:Array[String]
		for child in get_children():
			if "progress_hidden" in child:
				if !child.progress_hidden:
					progress.append(child.progress)
		UI_node_data.text = description + "\n"
		for line in progress:
			UI_node_data.text += "\t" + line + "\n"
	
func activate() -> void:
	current_state = GoalState.ACTIVE
	if !hidden:
		UI_node.visible = true #TODO: animate this
	goal_started.emit()
	
#TODO: animate the goal_ui to show an update, receive a signal from subcomponants
func _on_goal_progress_update():
	pass

func _on_goal_completed()-> void:
	display_progress()
	if current_state != GoalState.ACTIVE:
		return
	current_state = GoalState.COMPLETED
	completed.emit()
	goal_fade_out(true)	
	
	if priority == "Primary" : #TODO: this might cause problem because multiple primary goal branches can be active at the same time
		if next_goals.is_empty():
			end_level.emit(true) #true for sucess, false for fail
		else:
			for goal in next_goals:
					goal.activate()
			
func _on_goal_failed()-> void:
	display_progress()
	if current_state != GoalState.ACTIVE:
		return	
	current_state = GoalState.FAILED
	failed.emit()
	goal_fade_out(false)
	
	if priority == "Primary" : 
			end_level.emit(false) #true for sucess, false for fail
	
func goal_fade_out(success:bool):
	if !hidden:
		if success:
			UI_node.modulate = Color(0, 1, 0)
		else:
			UI_node.modulate = Color(1, 0, 0)
	#TODO: animate the goal_ui node to make it fade out
