extends Label

var wheatley
var http_cake

func _ready():
	wheatley = get_node("/root/Wheatley")
	
	http_cake = HTTPRequest.new()
	http_cake.set_use_threads(true)
	add_child(http_cake)
	http_cake.request_completed.connect(_on_request_completed)
	
	http_cake.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/cakeholder")

func _on_request_completed(result, response_code, headers, body: PackedByteArray):
		if response_code == 200:
			var json = JSON.parse_string(body.get_string_from_utf8())
			wheatley.set_meta("Cakeholder", json)
			if(typeof(json["User"]) != TYPE_FLOAT):
				self.set_text("Current Cake Holder: " + str(json["User"]))
			else:
				self.set_text("Current Cake Holder: " + "Aperture")
