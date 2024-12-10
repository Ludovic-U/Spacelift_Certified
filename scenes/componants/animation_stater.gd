extends Node

@export var animation:AnimationPlayer
@export var animation_name:String = "cinematic"

func _on_start_animation() -> void:
	animation.play(animation_name)
