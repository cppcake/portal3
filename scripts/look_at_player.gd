extends Sprite2D

var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = player.position
	look_at(pos)
