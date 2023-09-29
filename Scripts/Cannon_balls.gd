extends Node

var cannon_balls = ["Cannon Ball","Fire Ball","Sleeping Gas Ball"]

func get_ball_id(name : String):
	return cannon_balls.find(name)
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
	return 10
	
func sleeping_gas_ball():
	return 0
#id 1
func fire_ball():
	return 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
