extends Button

var wheatley
var item_info
var player_info
var ah

var http_sell
var sign
var ih

func _ready():
	wheatley = get_node("/root/Wheatley")
	item_info = wheatley.get_meta("Shop")
	player_info = wheatley.get_meta("Player_Info")
	
	http_sell = HTTPRequest.new()
	http_sell.set_use_threads(true)
	add_child(http_sell)
	http_sell.request_completed.connect(_on_request_completed)
	
	ah = wheatley.get_meta("Account_Handle")
	ih = item_info["ih"]

	sign = get_node("../Status")

func _on_request_completed(result, response_code, headers, body: PackedByteArray):
	print("sell request completed, result: " + str(result))
	if response_code == 200:
		get_tree().change_scene_to_file("res://level/ItemView.tscn")
	else:
		set_text("Nice try, but we thought of that :)")
	
func _on_pressed():
	print("click")
	print("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") +  "/co/" + str(ah) + "/" + str(ih) + "/1")
	var error = http_sell.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") +  "/co/" + str(ah) + "/" + str(ih) + "/1", [], HTTPClient.METHOD_POST)
	if error != OK:
		print("error:" + str(error))
		sign.set_text("Error, likely no internet")
