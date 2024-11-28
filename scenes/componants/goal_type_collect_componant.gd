class_name GoalCollect extends Node

@export var item_class:String
#if number_to_collect is 0, the default goal will be to collect all items
@export var number_to_collect:int = 0
var number_collected:int = 0

func _ready() -> void:
	if number_to_collect == 0 :
		var collectibles = get_tree().get_nodes_in_group("collectibles")
		for item in collectibles:
			if item.get_script():
				if item.get_script().get_global_name() == item_class:
					number_to_collect += 1
		print("collect ", number_to_collect, " ", item_class)
