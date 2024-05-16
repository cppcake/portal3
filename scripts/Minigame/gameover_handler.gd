extends Control

var wheatley
var ah
var http_minigame
var http_highscore

var gameov
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	wheatley = get_node("/root/Wheatley")
	gameov = get_node("/root/root/CanvasLayer/Gameover")
	player = get_node("/root/root/Player")
	
func gameover(score):
	if wheatley.get_meta("top_score") < score:
		wheatley.set_meta("top_score", score)
	
	var music = load("res://sounds/music/dead.mp3")
	player.get_node("AudioStreamPlayer2D").set_stream(music)
	player.get_node("AudioStreamPlayer2D").play()
	gameov.get_node("CenterContainer/VBoxContainer/Label").set_text("Score: " + str(score) + " (still no cake)" + '\n' + "+" + str(score) + " Companion Dollars!")
	gameov.visible = true
	get_tree().paused = true

func _on_try_again_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://level/Minigame.tscn")
	
func _on_back_hub_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://level/Hub.tscn")

func _on_quit_pressed():
	get_tree().change_scene_to_file("res://level/Exit.tscn")
