class_name TimeSystem extends Node

var elapsed:float = 0.0

func _process(delta):
	elapsed += delta

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
