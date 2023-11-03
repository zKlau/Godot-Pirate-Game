extends Node

@export var day_length : float = 20.0
@export var start_time : float = 0.5
@export var sun_color : Gradient
@export var sun_intensity : Curve
var time_rate
var time

@export var moon_color : Gradient
@export var moon_intensity : Curve
# Called when the node enters the scene tree for the first time.
func _ready():
	time_rate = 1.0 / day_length
	time = start_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	daynight_cycle(delta)
	pass


func daynight_cycle(delta):
	time += time_rate * delta
	if time >= 1.0:
		time = 0
		
	print($Day_Time.get_time_left())
	$Sun.rotation_degrees.x =  time * 360 + 90#(360/360) * $Day_Time.get_time_left()
	$Sun.light_color = sun_color.sample(time)
	$Sun.light_energy = sun_intensity.sample(time)
	
	$Moon.rotation_degrees.x =  time * 360 + 270#(360/360) * $Day_Time.get_time_left()
	$Moon.light_color = moon_color.sample(time)
	$Moon.light_energy = moon_intensity.sample(time)
