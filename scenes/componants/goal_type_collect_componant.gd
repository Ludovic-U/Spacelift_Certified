class_name GoalCollect extends Node

signal goal_completed

var GOAL:GoalComponant
@export var item_class:String
#if number_to_collect is 0, the default goal will be to collect all items
@export var number_to_collect:int = 0
var number_collected:int = 0

func _ready() -> void:
	GOAL = get_parent()
	if number_to_collect == 0 :
		var collectibles = get_tree().get_nodes_in_group("collectibles")
		for item in collectibles:
			if item.get_script():
				if item.get_script().get_global_name() == item_class:
					number_to_collect += 1
		print("collect ", number_to_collect, " ", item_class)


func _on_collect(body)-> void:
	if body.get_script():
		if body.get_script().get_global_name() == item_class:
			number_collected += 1
			print(number_collected)
			if number_collected >= number_to_collect:
				goal_completed.emit()
