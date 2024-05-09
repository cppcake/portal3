extends Node

@export var path = ""
@export var uri = "http://127.0.0.1:8000/register/lool/123"

var wheatley
func _ready():
	wheatley = get_node("/root/Wheatley")
	
	get_node("BG/Connect/Button_Connect").pressed.connect(_on_button_pressed)

func _on_request_completed(result, response_code, headers, body: PackedByteArray):
	pass
	print("i heard that")

func _on_button_pressed():
	pass
	#var error = wheatley.request(uri)
