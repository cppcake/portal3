extends Node2D

var player

var blue
var orange

var test
var init_pos

var audio_enter
var audio_open
var audio_invalid

func _ready():
	Input.set_custom_mouse_cursor(preload("res://sprites/curser_init.png"), Input.CURSOR_ARROW, Vector2(24,24))
	
	player = get_node("../Player")
	
	blue = get_node("Blue")
	orange = get_node("Orange")
	
	test = get_node("Test")
	init_pos = test.position
	
	audio_enter = get_node("../Player/AudioPortalEnter")
	audio_open = get_node("../Player/AudioPortalOpen")
	audio_invalid = get_node("../Player/AudioPortalInvalid")

func _process(delta):
	if Input.is_action_just_pressed("M1"):
		try_place(blue)
	else:
		if Input.is_action_just_pressed("M2"):
			try_place(orange)

func try_place(portal):
	var mousepos = get_global_mouse_position()
	test.position = mousepos
	
	await get_tree().create_timer(0.10).timeout
	var bodieshit = test.get_overlapping_bodies()
	
	if (bodieshit == [] or bodieshit == [player]) and (!test.has_overlapping_areas() or test.overlaps_area(portal)):
		portal.visible = true
		if !orange.visible and blue.visible:
			Input.set_custom_mouse_cursor(preload("res://sprites/curser_blue.png"), Input.CURSOR_ARROW, Vector2(24,24))
		if orange.visible and !blue.visible:
			Input.set_custom_mouse_cursor(preload("res://sprites/curser_oranget.png"), Input.CURSOR_ARROW, Vector2(24,24))
		if orange.visible and blue.visible:
			Input.set_custom_mouse_cursor(preload("res://sprites/curser_full.png"), Input.CURSOR_ARROW, Vector2(24,24))
		
		orange.set_meta("state", 0)
		blue.set_meta("state", 0)
		
		portal.position = mousepos
		test.position = init_pos
		audio_open.play()
		
		await get_tree().create_timer(0.05).timeout
		if blue.overlaps_body(player):
			_on_blue_body_entered(player)
		else:
			if orange.overlaps_body(player):
				_on_orange_body_entered(player)
	else:
		if not audio_invalid.playing:
			audio_invalid.play()

func _on_blue_body_entered(body):
	if orange.visible and blue.visible:
		if body == player:
			match blue.get_meta("state"):
				0:
					orange.set_meta("state", 1)
					player.position = orange.position
					audio_enter.play()
	#print("enter_blue")	
func _on_blue_body_exited(body):
	if body == player:
		#await get_tree().create_timer(0.035).timeout
		blue.set_meta("state", 0)
		#print("exit_blue")

func _on_orange_body_entered(body):
	if blue.visible and orange.visible:
		if body == player:
			match orange.get_meta("state"):
				1:
					return
				0:
					blue.set_meta("state", 1)
					player.position = blue.position
					audio_enter.play()
	#print("enter_orange")
func _on_orange_body_exited(body):
	if body == player:
		#await get_tree().create_timer(0.035).timeout
		orange.set_meta("state", 0)
		#print("exit_orange")
