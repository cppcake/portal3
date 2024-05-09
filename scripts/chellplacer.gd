extends Sprite2D

var player
var wheatley
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	wheatley = get_node("/root/Wheatley")
	
	match wheatley.get_meta("chell_pos"):
		0:
			player.position = Vector2(1016, 632)
		1:
			player.position = Vector2(224, 432)
		2:
			player.position = Vector2(680, 168)
		3:
			player.position = Vector2(1056, 280)
