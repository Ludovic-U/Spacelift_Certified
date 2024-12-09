class_name GoalTime extends Node

signal goal_completed

var progress:String
@export var progress_hidden:bool = false
@export var progress_text:String = "time left"

@export_enum("Countdown", "Chronometer") var time_mode = "Countdown"
# limit == 0 will never trigger the goal_completed signal
@export var limit:float = 0.0
var elapsed:float = 0.0
var running:bool = false

func _on_start() -> void:
	running = true
	if time_mode == "Countdown":
		elapsed = limit
		
func _on_pause() -> void:
	running = false

func _process(delta):
	if running:
		if time_mode == "Countdown" && elapsed > 0.0:
			elapsed -= delta
			if elapsed <= 0.0:
				elapsed = 0.0
				goal_completed.emit()
				_on_pause()
		if time_mode == "Chronometer" && limit <= 0:
			elapsed += delta
		elif time_mode == "Chronometer" && elapsed >= limit:
			elapsed += delta
			goal_completed.emit()
			_on_pause()
		var hhmmss = time_to_hhmmss(elapsed)
#		#TODO: wrong second format
		progress = "%02d:%02d:%04.2f" %[hhmmss["hours"], hhmmss["minutes"], hhmmss["seconds"]] + progress_text

func time_to_hhmmss(total_time: float) -> Dictionary:
	#total_seconds = 12345
	var seconds:float = fmod(total_time , 60.0)
	var minutes:int   =  int(total_time / 60.0) % 60
	var hours:  int   =  int(total_time / 3600.0)
	var hhmmss_string:Dictionary = {
		"hours": hours,
		"minutes": minutes,
		"seconds": seconds,
	}
	return hhmmss_string
