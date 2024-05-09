extends Node2D

var player

var blue
var orange

var test
var init_pos

var audio_enter
var audio_open
var audio_invalid


@export_group("Portal Overlap Correction")

## Steuert wie viel Prozent der Fläche des Portals mit einem Hinderniss überlappen
## darf. Wenn das Portal weniger als maximum_portal_overlap überlappt wird es
## in richtung des cursors aus dem hinderniss heraus gezogen.
@export_range(0.0, 10.0) var maximum_portal_overlap: float = 0.4;

## Steuert die Schritt größe.
@export var step_size: int = 10;

## Steuert das generelle höhen offset pro Schritt.
@export var general_height_adjustment = 2;

## Steuert ob Portale automatisch beim überlappen von hindernissen
## aus diesen herausgezogen werden.
@export var enable_portal_overlap_correction: bool = true;


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
			
	if !orange.visible and blue.visible:
		Input.set_custom_mouse_cursor(preload("res://sprites/curser_blue.png"), Input.CURSOR_ARROW, Vector2(24,24))
	if orange.visible and !blue.visible:
		Input.set_custom_mouse_cursor(preload("res://sprites/curser_oranget.png"), Input.CURSOR_ARROW, Vector2(24,24))
	if orange.visible and blue.visible:
		Input.set_custom_mouse_cursor(preload("res://sprites/curser_full.png"), Input.CURSOR_ARROW, Vector2(24,24))
	if !orange.visible and !blue.visible:
		Input.set_custom_mouse_cursor(preload("res://sprites/curser_init.png"), Input.CURSOR_ARROW, Vector2(24,24))
	
func _adjust_portal_position(limit: float, adjust_direction: Vector2):
	print(limit)
	# Falls das limit <= 0 ist braucht die position nicht angepasst werden.
	if limit <= 0:
		return
	
	# Falls das Portal mit keinen Bodies überlappt braucht seine position nicht angepasst werden.
	await get_tree().process_frame
	var overlapping = test.get_overlapping_bodies();
	if len(overlapping) <= 0 or overlapping == [player]:
		return
		
	if adjust_direction.y >= 0:
		test.position.y += general_height_adjustment
	else:
		test.position.y -= general_height_adjustment
	
	# Zu gehende Schrittgröße finden.
	# Wenn das Limit kleiner als die Schrittgröße ist, wird das Limit
	# als Schrittgröße benutzt.
	var step = step_size
	if limit < step_size:
		step = limit
		
	test.position += adjust_direction * step_size
	await _adjust_portal_position(limit-step_size, adjust_direction)
	
func try_place(portal):
	var mousepos = get_global_mouse_position()
	test.position = mousepos
	
	if enable_portal_overlap_correction:
		# Ein Limit dafür finden um wie viel das Portal bewegt werden darf.
		# Das Portal wurde mit sicherheit so bewegt, dass es ein portal weit weg
		# von seiner Ursprungs position ist, wenn es um die länge des Vektors der
		# aus seinen diemensionen besteht bewegt wurde.
		# dieses limit wird über maximum_portal_overlap weiter angepasst.
		var portal_size = get_node("Test/CollisionShape2D").shape.extents
		var limit = portal_size.length() * maximum_portal_overlap
		
		# Berechnet einen vektor der von der Position der Maus in richtung Spieler Zeigt.
		var direction = ((mousepos + Vector2(0,-1))-mousepos).normalized()
		await _adjust_portal_position(limit, direction)
	
	#await get_tree().create_timer(0.05).timeout
	await get_tree().process_frame
	var bodieshit = test.get_overlapping_bodies()
	
	if (bodieshit == [] or bodieshit == [player]) and (!test.has_overlapping_areas() or test.overlaps_area(portal) or test.overlaps_area(get_node("/root/root/new_section_placer"))):
		portal.visible = true
		
		orange.set_meta("state", 0)
		blue.set_meta("state", 0)
		
		portal.position = test.position
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
	if player.position.x < 1281:
		if body == player:
			#await get_tree().create_timer(0.035).timeout
			blue.set_meta("state", 0)
	else:
		if body == player:
			blue.visible = 0
			orange.visible = 0

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
	if player.position.x < 1281:
		if body == player:
			#await get_tree().create_timer(0.035).timeout
			orange.set_meta("state", 0)
	else:
		if body == player:
			blue.visible = 0
			orange.visible = 0
