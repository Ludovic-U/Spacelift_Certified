extends Control

func _ready():
	if Global.current_level.leaderboard_name != "":
		%Leaderbord._create_leaderboard(Global.current_level.leaderboard_name)
		%score.text += "%4.2f" % Global.current_level.score
	else :
		$ScrollContainer.visible = false
		%score.visible = false
