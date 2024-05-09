extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Gameover").gameover(2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
