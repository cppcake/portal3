extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_global_mouse_position()
	look_at(pos)
	
