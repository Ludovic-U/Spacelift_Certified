class_name GameController extends Node

@export var WORLD_3D: Node3D
@export var INTERFACE: Control

var current_3D_scene
var current_UI_scene

# Called when the node enters the scene tree for the first time.
func _ready() :
	Global.game_controller = self
	current_3D_scene = WORLD_3D.get_child(0)
	current_UI_scene = INTERFACE.get_child(0)
