class_name PropertyCheck extends Node

signal check

@export var node_to_check:Node
@export var property_to_check:String
enum Comparisons {IS_EQUAL, IS_GREATER, IS_LOWER}
@export var comparison: Comparisons
@export var property_expected_value:String
var operation:Callable

func _ready():
	var property_type:String = type_string(typeof(node_to_check.get(property_to_check)))
	match property_type:
		"float":
			operation = Callable(self, "check_float")
		"String":
			operation = Callable(self, "check_string")
		"bool":
			operation = Callable(self, "check_bool")
		_: 
			push_error("property_check_componant : invalid type")
	
func start():
	set_process_mode(Node.PROCESS_MODE_INHERIT)
	
func stop():
	set_process_mode(Node.PROCESS_MODE_DISABLED)
	
func _process(_delta):
	check_property()
	
func check_property():
	var res:bool = operation.call()
	if res:
		check.emit()

func check_float() -> bool :
	var current_value:float = node_to_check.get(property_to_check)
	match comparison:
		Comparisons.IS_EQUAL:
			return current_value == float(property_expected_value)
		Comparisons.IS_GREATER:
			return current_value > float(property_expected_value)
		Comparisons.IS_LOWER:
			return current_value < float(property_expected_value)
		_: 
			push_error ( "Check_float went wrong" )
			return false
	
func check_string() -> bool :
	var current_value:String = node_to_check.get(property_to_check)
	return current_value == property_expected_value
	
func check_bool() -> bool :
	var current_value:bool = node_to_check.get(property_to_check)
	if property_expected_value == "true":
			return current_value
	if property_expected_value == "false":
			return !current_value
	push_error ( "Check_bool went wrong" )
	return false
	
	
	
	
