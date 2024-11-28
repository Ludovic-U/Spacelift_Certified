class_name GoalComponant extends Node

signal end_level

enum GoalState {INACTIVE, ACTIVE, COMPLETED, FAILED}
var current_state: GoalState = GoalState.INACTIVE
@export_flags("Primary", "Secondary") var goal_priority = 0
@export var next_goals: Array[GoalComponant]

enum GoalType {COLLECT, REACH} #TODO: move in its own componant
@export var goal_type:GoalType = GoalType.COLLECT
@export var intro_cutscene:AnimationPlayer

func _ready():
	#TODO: Intro
	pass

func _on_goal_completed():
	current_state = GoalState.COMPLETED
	for goal in next_goals:
				goal.current_state = GoalState.ACTIVE
				
	if goal_priority == "Primary":
		if next_goals.is_empty():
			end_level.emit()
			
func _on_goal_failed():
	current_state = GoalState.FAILED
	
	
