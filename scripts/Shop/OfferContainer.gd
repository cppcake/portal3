extends VBoxContainer

var wheatley
var item_info
var player_info

var http_offers

func _ready():
	wheatley = get_node("/root/Wheatley")
	item_info = wheatley.get_meta("Shop")
	player_info = wheatley.get_meta("Player_Info")
	
	http_offers = HTTPRequest.new()
	http_offers.set_use_threads(true)
	add_child(http_offers)
	http_offers.request_completed.connect(_on_request_completed)

	print('\n' + "Offer logic:")
	print("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/info/offers")
	http_offers.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/info/offers")

func _on_request_completed(result, response_code, headers, body: PackedByteArray):
	print("offer request completed, result: " + str(result))
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		var i = 0
		for offer in json["offers"]:
			if item_info["Name"] == offer["Name"]:
				var offerview = load("res://misc/shop/offer_view.tscn").instantiate()
				offerview.set_meta("oh", offer["oh"])
				offerview.set_meta("name", offer["VerkäuferName"])
				offerview.set_meta("count", offer["Anzahl"])
				i += offer["Anzahl"]
				
				print(offerview.get_meta("oh"))
				print(offerview.get_meta("name"))
				print(offerview.get_meta("count"))
				
				add_child(offerview)
		get_node("/root/Control/VBoxContainer/i/ii/Stock").set_text("Stock: " + str(i))
	else:
		print("Response code: " + str(response_code))
