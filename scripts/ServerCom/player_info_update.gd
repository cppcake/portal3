extends Control

var wheatley

var http_player_info

var id_holder

func _ready():
	wheatley = get_node("/root/Wheatley")
	
	http_player_info = HTTPRequest.new()
	http_player_info.set_use_threads(true)
	add_child(http_player_info)
	http_player_info.request_completed.connect(_on_request_completed)

	id_holder = get_node("ID")
	
	print("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/info/acc/" + wheatley.get_meta("Account_Handle"))
	http_player_info.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/info/acc/" + wheatley.get_meta("Account_Handle"))

func _on_request_completed(result, response_code, headers, body: PackedByteArray):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		id_holder.set_text("Name: " + str(json["User"]) + " (" + wheatley.get_meta("Account_ID") + ')' +  '\n' + "Companion Dollars: " + str(json["money"]))
		wheatley.set_meta("Player_Info", json)
	else:
		id_holder.set_text("Something went horribly wrong..." + '\n' + "What did you do... you monster")
