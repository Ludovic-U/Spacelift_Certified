class_name GoalReach extends Node


signal goal_completed

var progress:String
@export var progress_hidden:bool = false
@export var progress_text:String = "m away."

@export var area_to_reach:Area3D
@export var body_to_move:PhysicsBody3D
@export var distance_approx:float

func _on_check_area():
	if body_to_move in area_to_reach.get_overlapping_bodies():
		goal_completed.emit()

func _on_reach(body):
	if body == body_to_move:
		goal_completed.emit()
		
func _process(_delta):
	progress = "%4.2f" % (body_to_move.position.distance_to(area_to_reach.position) - distance_approx) + progress_text
