extends Control

var text_id
var text_port
var wheatley
# Called when the node enters the scene tree for the first time.
func _ready():
	text_id = get_node("Text_IP")
	text_port = get_node("Text_PORT")
	wheatley = get_node("/root/Wheatley")


func _on_button_connect_options_pressed():
	if(!text_id.visible):
		get_node("Button_Connect_Options").set_text("I told you not to touch it")
	else:
		get_node("Button_Connect_Options").set_text("Dev Options (dont touch)")
		wheatley.set_meta("IP", "139.162.139.67")
		wheatley.set_meta("Port", "8000")
	text_id.set_visible(!text_id.visible)
	text_port.set_visible(!text_port.visible)
