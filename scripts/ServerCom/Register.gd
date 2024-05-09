extends Control

var wheatley
var http_register
var sign
var name_holder
var pw_holder

func _ready():
	wheatley = get_node("/root/Wheatley")
	
	http_register = HTTPRequest.new()
	http_register.set_use_threads(true)
	add_child(http_register)
	http_register.request_completed.connect(_on_request_completed)

	sign = get_node("Register_Status")
	name_holder = get_node("Register/Text_Name")
	pw_holder = get_node("Register/Text_PW")

func _on_request_completed(result, response_code, headers, body: PackedByteArray):
	print("request completed, result: " + str(result))
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		sign.set_text("Your ID (write it down!): " + json["aid"])
		wheatley.set_meta("Accoutn_ID", json["aid"])
		get_node("../Connect/Text_ID").set_text(json["aid"])
	else:
		if(response_code == 0):
			sign.set_text("Cant connect to server")
		else:
			sign.set_text("Name or password missing")

func _on_button_register_pressed():
	var ip_holder = get_node("../Dev/Text_IP")
	var port_holder = get_node("../Dev/Text_PORT")
	if ip_holder.visible:
		wheatley.set_meta("IP", ip_holder.get_text())
		wheatley.set_meta("Port", port_holder.get_text())
		
	print("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/register/" + name_holder.get_text() + "/" + pw_holder.get_text())
	var error = http_register.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/register/" + name_holder.get_text() + "/" + pw_holder.get_text())
	if error != OK:
		print("error:" + str(error))
		sign.set_text("Cant connect to server" + '\n' + "What did you do... you monster")
