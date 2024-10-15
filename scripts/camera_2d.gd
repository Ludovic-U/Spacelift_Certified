extends Camera2D

#The camera should always be a direct child of the current_scene
@export var min_zoom:float = 0.1
@export var max_zoom:float = 2.0
@export var zoom_step:float = 0.1
@export var zoom_smoothing:float = 0.1

var zoom_level:Vector2 = self.zoom
var player_corrected_rotation:float
var PLAYER : Player
var SPACE: Node2D

func _ready():
	SPACE = get_tree().current_scene
	PLAYER = SPACE.find_child("player", true, true)

func _process(_delta):
	if PLAYER != null:
		var global_node_data = find_global_position(PLAYER.Camera_follows)
		global_position = global_node_data["position"]
		player_corrected_rotation = global_node_data["corrected_rotation"]
	if Input.is_action_just_pressed("Mouse_Wheel_Down") && zoom_level > Vector2(min_zoom, min_zoom):
		zoom_level -= Vector2(zoom_step, zoom_step)
	if Input.is_action_just_pressed("Mouse_Wheel_Up") && zoom_level < Vector2(max_zoom, max_zoom) :
		zoom_level += Vector2(zoom_step, zoom_step)
	self.zoom = lerp(self.zoom, zoom_level, zoom_smoothing)
	
#return the global node position and rotation even though it may be a parent of a subviewport
func find_global_position(node) -> Dictionary:
	var global_data:Dictionary
	if node.get_parent() == SPACE:
		global_data = {"position":node.position, "corrected_rotation":0.0}
	elif node.get_parent() is SubViewport:
		var VPcontainer:ShipInteriorWorldContainer = node.get_parent().get_parent()
		global_data = find_global_position(VPcontainer.SHIP)
		global_data["corrected_rotation"] += VPcontainer.SHIP.rotation
		global_data["position"] += (node.position + VPcontainer.position).rotated(global_data["corrected_rotation"])
		
	return global_data
