extends Label

var wheatley
var http_score

func _ready():
	wheatley = get_node("/root/Wheatley")
	
	http_score = HTTPRequest.new()
	http_score.set_use_threads(true)
	add_child(http_score)
	http_score.request_completed.connect(_on_request_completed)
	
	http_score.request("http://" + wheatley.get_meta("IP") + ":" + wheatley.get_meta("Port") + "/highscore")

func _on_request_completed(result, response_code, headers, body: PackedByteArray):
		if response_code == 200:
			var json = JSON.parse_string(body.get_string_from_utf8())
			wheatley.set_meta("highscore", json)
			self.set_text("Server High-Score: " + str(json["Score"]) + " by " + str(json["User"]))
