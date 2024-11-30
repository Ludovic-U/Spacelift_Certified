class_name GoalComponant extends Node

signal end_level

enum GoalState {INACTIVE, ACTIVE, COMPLETED, FAILED}
var current_state: GoalState = GoalState.INACTIVE
@export_enum("Primary", "Secondary") var priority: String = "Primary"
@export var next_goals: Array[GoalComponant]
@export var intro_cutscene:AnimationPlayer

func _ready():
	for child in get_children():
		if Utility.object_has_signal(child, "goal_completed"):
			child.goal_completed.connect(_on_goal_completed)
		if Utility.object_has_signal(child, "goal_failed"):
			child.goal_failed.connect(_on_goal_failed)
			
	#TODO: Intro
	pass
	
#TODO: func _on_activate() -> void:
	#for goal in next_goals:
					#goal.current_state = GoalState.ACTIVE 

func _on_goal_completed()-> void:
	if current_state != GoalState.ACTIVE:
		return
		
	current_state = GoalState.COMPLETED
	print("completed")
				
	if priority == "Primary" : #this might cause problem because multiple primary goal branches can be active at the same time
		if next_goals.is_empty():
			end_level.emit(1) #1 for sucess, 0 for fail
			print("end_level")
			
func _on_goal_failed()-> void:
	if current_state != GoalState.ACTIVE:
		return
		
	current_state = GoalState.FAILED
	if priority == "Primary" : 
			end_level.emit(0) #1 for sucess, 0 for fail
			print("end_level")
	
	#TODO: Create a GoalFail componant
	

	
	
