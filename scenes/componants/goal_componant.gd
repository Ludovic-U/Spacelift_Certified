class_name GoalComponant extends Node

signal end_level(success_state:int)
signal completed
signal failed
signal create_goal_ui
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
	#for child in get_children():
		#if Utility.object_has_signal(child, "goal_completed"): #connect through editor?
			#child.goal_completed.connect(_on_goal_completed)
		#if Utility.object_has_signal(child, "goal_failed"):
			#child.goal_failed.connect(_on_goal_failed)
		#if "description" in child:
			#description += child.description + " "
			
	#TODO: create UI node
	if !hidden:
		create_goal_ui.emit(self)
		UI_node = load("res://Interface/menu/Goal_UI.tscn").instantiate()
		Global.goal_list_ui.append(UI_node)
		UI_node_data = UI_node.find_child("Data")
	#TODO: Intro
	
func _process(_delta):
	if !hidden && current_state == GoalState.ACTIVE:
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
	goal_started.emit()
	
#TODO: animate the goal_ui to show an update

func _on_goal_completed()-> void:
	if current_state != GoalState.ACTIVE:
		return
		
	current_state = GoalState.COMPLETED
	completed.emit()
	
	#animate the goal_ui node to show its completion
	UI_node.modulate = Color(0, 1, 0)
	
	if priority == "Primary" : #this might cause problem because multiple primary goal branches can be active at the same time
		if next_goals.is_empty():
			end_level.emit(1) #1 for sucess, 0 for fail
		else:
			for goal in next_goals:
					goal.activate()
			
func _on_goal_failed()-> void:
	if current_state != GoalState.ACTIVE:
		return
		
	#animate the goal_ui node to show its completion
	UI_node.modulate = Color(1, 0, 0)
		
	current_state = GoalState.FAILED
	failed.emit()
	if priority == "Primary" : 
			end_level.emit(0) #1 for sucess, 0 for fail
			print("end_level")
	
	#TODO: Create a GoalFail componant
	

	
	
