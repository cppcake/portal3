extends ItemList

var wheatley
var http_shop

var sign 

var conv = [0, 1, 2, 4, 5, 9, 3, 10, 11, 6, 7, 8, 15, 13, 12, 14, 16, 17]

func _ready():
	wheatley = get_node("/root/Wheatley")
	
	http_shop = HTTPRequest.new()
	add_child(http_shop)
	http_shop.request_completed.connect(_on_request_completed)
	
	sign = get_node("../sign")
	
func _on_request_completed(result, response_code, headers, body: PackedByteArray):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		wheatley.set_meta("Shop", json)
		print(json)
		get_tree().change_scene_to_file("res://level/ItemView.tscn")
	else:
		sign.set_text("Cant connect to server...")
		print("Something went horribly wrong..." + '\n' + "What did you do... you monster")

func _on_item_clicked(index, at_position, mouse_button_index):
	print("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/info/items/" + str(conv[index]))
	http_shop.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/info/items/" + str(conv[index]))
