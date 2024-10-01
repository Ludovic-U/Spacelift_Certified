extends Camera2D

@export var min_zoom:float = 0.1
@export var max_zoom:float = 2.0
@export var zoom_step:float = 0.1

var PLAYER: Node2D
var SPACE: Node2D

func _ready():
	SPACE = $".."
	PLAYER = SPACE.find_child("player", true, true)
	print(find_true_position(PLAYER))

func _process(_delta):
	if PLAYER != null:
		global_position = find_true_position(PLAYER)
	if Input.is_action_just_pressed("Mouse_Wheel_Down") && self.zoom > Vector2(min_zoom, min_zoom):
		self.zoom -= Vector2(zoom_step, zoom_step)
	if Input.is_action_just_pressed("Mouse_Wheel_Up") && self.zoom < Vector2(max_zoom, max_zoom) :
		self.zoom += Vector2(zoom_step, zoom_step)
#
func find_true_position(node) -> Vector2:
	var true_position = Vector2.ZERO
	if node.get_parent() == SPACE:
		true_position = node.position
	elif node.get_parent() is SubViewport:
		var VPcontainer:ShipInteriorWorldContainer = node.get_parent().get_parent()
		true_position = find_true_position(VPcontainer.SHIP) + (node.position + VPcontainer.position).rotated(VPcontainer.SHIP.rotation)
	return true_position
