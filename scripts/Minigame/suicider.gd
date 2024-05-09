extends Node2D

var init_time

func _ready():
	init_time = Time.get_ticks_msec()
	
func _process(delta):
	if Time.get_ticks_msec() - init_time > 15000:
		print("Change the world. My final Message: Goodbye")
		queue_free()
