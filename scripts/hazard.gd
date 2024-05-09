extends Area2D

var player
var gameover_handler
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("/root/root/Player")
	gameover_handler = get_node("/root/root/CanvasLayer/Gameover")

func _on_body_entered(body):
	if body == player:
		gameover_handler.gameover(int((player.position.x - 1280) / 50))
