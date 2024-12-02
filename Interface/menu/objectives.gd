extends Control


func _ready():
	for goal in Global.goal_list_ui:
		if goal != null:
			$ScrollContainer/Goal_List.add_child(goal)
