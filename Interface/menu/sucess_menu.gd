extends Control

func _ready():
	if Global.current_level.leaderboard_name != "":
		%Leaderbord._create_leaderboard(Global.current_level.leaderboard_name)
	else :
		$ScrollContainer.visible = false
