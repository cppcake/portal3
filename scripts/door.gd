extends Area2D

@export_group("Chell Door Placer")

@export var placer_enabled: bool = false
@export var place: int = 5

var entered = false

var label
var info

@export var path = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	label = get_node("Label")
	info = label.get_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered:
		if Input.is_action_just_pressed("Interact"):
			if placer_enabled:
				get_node("/root/Wheatley").set_meta("chell_pos", place)
			get_tree().change_scene_to_file(path)

func _on_body_entered(body):
	label.set_text("Press E")
	#print("11")
	entered = true
	
func _on_body_exited(body):
	label.set_text(info)
	#print("21")
	entered = false
