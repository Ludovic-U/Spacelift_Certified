class_name PropertyCheck extends Node

signal check

@export var nodes_to_check:Array[Node]
@export var properties_to_check:Array[String]
enum Comparisons {IS_EQUAL, IS_GREATER, IS_LOWER}
@export var comparison: Comparisons #TODO: make it better
@export var properties_expected_value:Array[String]
var operations:Array[Callable]

func _ready():
	for i in nodes_to_check.size():
		var node:Node = nodes_to_check[i]
		var property_type:String = type_string(typeof(node.get(properties_to_check[i])))
		match property_type:
			"float":
				operations.append(Callable(self, "check_float"))
			"String":
				operations.append(Callable(self, "check_string"))
			"bool":
				operations.append(Callable(self, "check_bool"))
			_: 
				push_error("property_check_componant : invalid type")
	
func start():
	set_process_mode(Node.PROCESS_MODE_INHERIT)
	
func stop():
	set_process_mode(Node.PROCESS_MODE_DISABLED)
	
func _process(_delta):
	check_property()
	
func check_property():
	var total_check:int = 0
	for i in operations.size():
		var node:Node = nodes_to_check[i]
		var property:String = properties_to_check[i]
		var value:String = properties_expected_value[i]
		var res:bool = operations[i].call(node, property, value)
		if res:
			total_check += 1
	if total_check == operations.size():
		check.emit()
		stop()

func check_float(node:Node, property:String, value:String) -> bool :	
	var current_value:float = node.get(property)
	match comparison:
		Comparisons.IS_EQUAL:
			return current_value == float(value)
		Comparisons.IS_GREATER:
			return current_value > float(value)
		Comparisons.IS_LOWER:
			return current_value < float(value)
		_: 
			push_error ( "Check_float went wrong" )
			return false
	
func check_string(node:Node, property:String, value:String) -> bool :
	var current_value:String = node.get(property)
	return current_value == value
	
func check_bool(node:Node, property:String, value:String) -> bool :
	var current_value:bool = node.get(property)
	if value == "true":
			return current_value
	if value == "false":
			return !current_value
	push_error ( "Check_bool went wrong" )
	return false
	
	
	
	
