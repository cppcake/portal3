extends Node

var wheatley
var info

@export var ogname = ""

func _ready():
	wheatley = get_node("/root/Wheatley")
	info = wheatley.get_meta("Player_Info")
	
	for item in info["items"]:
		if item["Name"] == ogname and item["Besitz"] > 0:
			get_node("Label").set_text("Count: " + str(item["Besitz"]))
			self.visible = true
