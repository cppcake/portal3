extends Sprite2D


func _process(delta):
	var pos = get_global_mouse_position()
	
	if (pos.x - get_parent().position.x) < 0:
		flip_h = true
		get_node("Portal Gun").flip_v = true
	else:
		flip_h = false
		get_node("Portal Gun").flip_v = false
