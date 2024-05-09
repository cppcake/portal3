extends Control

var wheatley
var http_login

var sign

var id_holder
var pw_holder

var ip_holder
var port_holder

func _ready():
	wheatley = get_node("/root/Wheatley")
	
	http_login = HTTPRequest.new()
	http_login.set_use_threads(true)
	add_child(http_login)
	http_login.request_completed.connect(_on_request_completed)

	sign = get_node("Connect_Status")
	
	id_holder = get_node("Text_ID")
	pw_holder = get_node("Text_PW")
	
	ip_holder = get_node("../Dev/Text_IP")
	port_holder = get_node("../Dev/Text_PORT")

func _on_request_completed(result, response_code, headers, body: PackedByteArray):
	print("working on request")
	if response_code == 200:
		wheatley.set_meta("Account_ID", id_holder.get_text())
		var json = JSON.parse_string(body.get_string_from_utf8())
		print(str(json["ah"]))
		wheatley.set_meta("Account_Handle", str(json["ah"]))
		get_tree().change_scene_to_file("res://level/Hub.tscn")
	else:
		sign.set_text("Wrong password or ID" + '\n' + "(or the server is broken)")


func _on_button_connect_pressed():
	if ip_holder.visible:
		wheatley.set_meta("IP", ip_holder.get_text())
		wheatley.set_meta("Port", port_holder.get_text())
	
	print("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/login/" + id_holder.get_text() + "/" + pw_holder.get_text())
	var error = http_login.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/login/" + id_holder.get_text() + "/" + pw_holder.get_text())
	if error != OK:
		sign.set_text("Cant connect to server" + '\n' + "What did you do... you monster")
