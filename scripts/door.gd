extends Area2D

@export_group("Chell Door Placer")

@export var placer_enabled: bool = false
@export var place: int = 5

var entered = false
var wheatley
var label
var info

@export var path = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	wheatley = get_node("/root/Wheatley")
	label = get_node("Label")
	info = label.get_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if entered:
		if Input.is_action_just_pressed("Interact"):
			if placer_enabled:
				wheatley.set_meta("chell_pos", place)
			get_tree().change_scene_to_file(path)

func _on_body_entered(_body):
	label.set_text("Press E")
	entered = true
	
func _on_body_exited(_body):
	label.set_text(info)
	entered = false
