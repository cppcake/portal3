extends Button

var wheatley
var item_info
var player_info
var ah

var http_buy
var sign
var oh

func _ready():
	wheatley = get_node("/root/Wheatley")
	item_info = wheatley.get_meta("Shop")
	player_info = wheatley.get_meta("Player_Info")
	
	http_buy = HTTPRequest.new()
	http_buy.set_use_threads(true)
	add_child(http_buy)
	http_buy.request_completed.connect(_on_request_completed)
	
	ah = wheatley.get_meta("Account_Handle")
	oh = get_node("../..").get_meta("oh")

	sign = get_node("../sign")

func _on_request_completed(result, response_code, headers, body: PackedByteArray):
	print("buy request completed, result: " + str(result))
	if response_code == 200:
		if item_info["Name"] == "Cake":
				var http_highscore = HTTPRequest.new()
				http_highscore.set_use_threads(true)
				add_child(http_highscore)
				http_highscore.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") +  "/cakeholder/" + wheatley.get_meta("Player_Info")["User"], [], HTTPClient.METHOD_POST)
		var json = JSON.parse_string(body.get_string_from_utf8())
		sign.set_text("You bought one piece!")
		await get_tree().create_timer(0.25).timeout
		get_tree().change_scene_to_file("res://level/ItemView.tscn")
	else:
		if int(item_info["Preis"]) > player_info["money"]:
			sign.set_text("You need to grind more, sorry pal")
		else:
			sign.set_text("Something went horribly wrong..." + '\n' + "What did you do... you monster")
	
func _on_pressed():
	if int(item_info["Preis"]) > player_info["money"]:
		sign.set_text("You need to grind more, sorry pal")
	else:
		self.disabled = true
		print("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") +  "/bo/" + str(ah) + "/" + str(oh) + "/1")
		var error = http_buy.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") +  "/bo/" + str(ah) + "/" + str(oh) + "/1", [], HTTPClient.METHOD_POST)
		if error != OK:
			self.disabled = false
			sign.set_text("Error, likely no internet")
