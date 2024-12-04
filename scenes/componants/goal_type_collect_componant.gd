class_name GoalCollect extends Node

signal goal_completed

var progress:String
@export var progress_hidden:bool = false
@export var progress_text:String = "item collected"

@export var item_class:String
#if number_to_collect is 0, the default goal will be to collect all items
@export var number_to_collect:int = 0
var number_collected:int = 0
	
func count_collectable_items()-> void:
	if number_to_collect == 0 :
		var collectibles = get_tree().get_nodes_in_group("collectibles")#TODO: make it more maintainable
		for item in collectibles:
			if item.get_script():
				if item.get_script().get_global_name() == item_class:
					number_to_collect += 1
	progress = "(%d/%d) " % [number_collected, number_to_collect] + progress_text


func _on_collect(body)-> void:
	if body.get_script():
		if body.get_script().get_global_name() == item_class:
			number_collected += 1
			progress = "(%d/%d) " % [number_collected, number_to_collect] + progress_text
			if number_collected >= number_to_collect:
				goal_completed.emit()
