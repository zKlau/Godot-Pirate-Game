@icon("res://Assets/Textures/Icons/ball-pyramid.svg")
class_name Ship_CannonBalls
extends Node

@export var cannon_ball_level : int = 1
@export var fireball_level : int = 1
@export var sleep_ball_level : int = 1

func get_ball_id(name : String):
	return CannonBalls.cannon_balls.find(name)
	
	
#copy from Cannon_balls.gd
func ball_type(id : int):
	match id:
		0:
			return cannon_ball()
		1: 
			return fire_ball()
		2:
			return sleeping_gas_ball()

#id 0
func cannon_ball():
	var re = cannon_ball_level
	return re
	
func sleeping_gas_ball():
	var re = fireball_level
	return re
#id 1
func fire_ball():
	var re = sleep_ball_level
	return re
