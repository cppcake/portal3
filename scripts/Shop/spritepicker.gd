extends Sprite2D

func _ready():
	var wheatley = get_node("/root/Wheatley")
	var dict = wheatley.get_meta("Shop")
	
	texture = load("res://sprites/Shop_Icons/" + str(dict["ih"]) + ".png")
	set_texture(texture)
