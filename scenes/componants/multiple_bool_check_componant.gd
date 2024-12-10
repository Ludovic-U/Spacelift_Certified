extends Node

signal check

var total_checked:int = 0
@export var check_number_required:int = 0

func _on_check() -> void:
	total_checked += 1
	if total_checked >= check_number_required:
		check.emit()
