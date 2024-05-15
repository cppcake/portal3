extends Node2D

var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/root/Player")

func _on_area_2d_body_entered(body):
	if body == player:
		body.velocity.y = -800
		player.get_node("gel").play()
