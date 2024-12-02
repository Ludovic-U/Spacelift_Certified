extends Node

@export var nodespath_and_properties:Dictionary
var collected_data:Array

func _on_collect_data() -> void:
	for key in nodespath_and_properties.keys():
		collected_data.append(get_node(key).get(nodespath_and_properties[key]))
