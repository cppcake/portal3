extends HBoxContainer

var seller_label
var count_label

func _ready():
	seller_label = get_node("VBoxContainer2/Seller")
	count_label = get_node("VBoxContainer2/Count")
	
	seller_label.set_text("Seller: " + get_meta("name"))
	count_label.set_text("Count: " + str(get_meta("count")))
