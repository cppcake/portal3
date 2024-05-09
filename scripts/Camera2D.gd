extends Camera2D

var player
var init_pos
var init_pos_player

var status
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../Player")
	
	init_pos = position.x
	init_pos_player = player.position.x
	
	status = get_node("Label")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var new_pos = init_pos +  (player.position.x - init_pos_player)
	if new_pos >= 0:
		position.x = new_pos
	if player.position.x > 1280:
		status.set_text(str(int((player.position.x - 1280) / 50)))
