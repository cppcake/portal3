extends Sprite2D

var portal_gun

func _ready():
	portal_gun = get_node("Portal Gun")

func _process(_delta):
	var pos = get_global_mouse_position()
	
	if (pos.x - get_parent().position.x) < 0:
		flip_h = true
		portal_gun.flip_v = true
	else:
		flip_h = false
		portal_gun.flip_v = false
