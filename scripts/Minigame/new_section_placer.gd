extends Area2D

var sections
var prev_section = 0
var player

var orange
var blue

var first = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var section_1 = preload("res://level/minigame_sections/section_1.tscn")
	var section_2 = preload("res://level/minigame_sections/section_2.tscn")
	var section_3 = preload("res://level/minigame_sections/section_3.tscn")
	var section_4 = preload("res://level/minigame_sections/section_4.tscn")
	var section_5 = preload("res://level/minigame_sections/section_5.tscn")
	var section_6 = preload("res://level/minigame_sections/section_6.tscn")
	var section_7 = preload("res://level/minigame_sections/section_7.tscn")
	var section_8 = preload("res://level/minigame_sections/section_8.tscn")
	var section_9 = preload("res://level/minigame_sections/section_9.tscn")
	var section_10_afeef = preload("res://level/minigame_sections/section_10_afeef.tscn")
	
	sections = [section_1, section_2, section_3, section_4, section_5, section_6, section_7, section_8, section_9, section_10_afeef]
	
	player = get_node("/root/root/Player")
	
	orange = get_node("/root/root/PortalControl/Orange")
	blue = get_node("/root/root/PortalControl/Blue")

func _on_body_entered(body):
	if body == player:
		if first == true:
			first = false
			var music = load("res://sounds/music/minigame_music.mp3")
			player.get_node("AudioStreamPlayer2D").set_stream(music)
			player.get_node("AudioStreamPlayer2D").play()
		
		var new_section = randi_range(0, sections.size() - 1)
		while new_section == prev_section:
			new_section = randi_range(0, sections.size() - 1)
		prev_section = new_section
		
		var instance = sections[new_section].instantiate()
		instance.position.x = position.x + 1280
		get_node("/root/root").add_child(instance)
		
		position.x += (1280 * 2)
