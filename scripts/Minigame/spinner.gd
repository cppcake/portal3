extends Node2D

@export var number: int = 3
@export var max_height: int = 500
@export var min_height: int = 200
@export var max_width: int= 1600
@export var min_width: int = 900
@export var speed_height: float = 5
@export var speed_width: float = 5
@export var direction: int = 1

func _process(delta):
	rotate(number * delta)
	if position.y > max_height:
		direction = -1
	
	if position.y < min_height:
		direction = 1
		
	position.y += direction * speed_height * delta * 60
	
	
	if position.x > max_width:
		direction = -1
	
	if position.x < min_width:
		direction = 1
		
	position.x += direction * speed_width * delta * 60
