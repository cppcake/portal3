extends Label

var wheatley

# Called when the node enters the scene tree for the first time.
func _ready():
	wheatley = get_node("/root/Wheatley")
	
	self.set_text("Top score (this session): " + str(wheatley.get_meta("top_score")))
