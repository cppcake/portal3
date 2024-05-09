extends VBoxContainer

func _ready():
	var wheatley = get_node("/root/Wheatley")
	var dict = wheatley.get_meta("Shop")
	
	$i/ii/Name.set_text("Name: " + dict["Name"])
	$i/ii2/Desc.set_text("Description: " + dict["Beschreibung"])
	$i/ii/Type.set_text("Rarity: " + dict["Typ"])
	$i/ii/Price.set_text("Price: " + str(dict["Preis"]))
