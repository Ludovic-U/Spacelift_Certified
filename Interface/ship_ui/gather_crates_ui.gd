extends Control

var level:Level

func _ready():
	level = Global.current_level

func _process(_delta):
	$time.text = str(level.time.time_to_hhmmss(level.time.elapsed))
