extends Node

var player
@export var rain : bool = false
@onready var rain_particles : GPUParticles3D = $Rain
@export var heavy_rain : bool = false
@export var rain_weight : int = 4000
@onready var env : Node = $".."
@export var wind_timer : int = 160
var time : float = 0;
var delta : float;
func _ready():
	player = Global.player
	pass
	
func _process(delta):
	time += delta
	delta = delta;
	_wind()
	if rain:
		if !$"Rain/Light Rain".playing:
			$"Rain/Light Rain".play()
		rain_particles.position.x = Global.player.global_position.x
		rain_particles.position.z = Global.player.global_position.z
		if heavy_rain:
			rain_particles.amount = rain_weight*2
		else:
			rain_particles.amount = rain_weight
		rain_particles.emitting = true
	else:
		$"Rain/Light Rain".stop()
		rain_particles.amount = rain_weight*2
		rain_particles.emitting = false
	pass


func _wind():
	if time >= wind_timer:
		#wind_timer *= randi_range(1.5,2.2)
		Global.wind = randi_range(1,8)
		time = 0;
		print(Global.wind)
		match Global.wind:
			1: # north
				%wind_direction.text = "Wind: North"
				Global.compass.change_texture("north-wind")
				Global.north_wind = 1.2
				Global.east_wind = 0.95
				Global.west_wind = 0.95
				Global.south_wind = 0.8
			2: #south
				%wind_direction.text = "Wind: South"
				Global.compass.change_texture("south-wind")
				Global.north_wind = 0.8
				Global.east_wind = 0.95
				Global.west_wind = 0.95
				Global.south_wind = 1.2
			3: #east
				%wind_direction.text = "Wind: East"
				Global.compass.change_texture("east-wind")
				Global.north_wind = 0.95
				Global.east_wind = 1.2
				Global.west_wind = 0.8
				Global.south_wind = 0.95
			4: #west
				%wind_direction.text = "Wind: West"
				Global.compass.change_texture("west-wind")
				Global.north_wind = 0.95
				Global.east_wind = 0.8
				Global.west_wind = 1.2
				Global.south_wind = 0.95
			5,6,7,8: # none
				%wind_direction.text = "Wind: None"
				Global.compass.change_texture("normal")
				Global.north_wind = 1
				Global.east_wind = 1
				Global.west_wind = 1
				Global.south_wind = 1
			
	
	pass
func _on_rain_timer_timeout():
	var clouds_cutoff = randf_range(0,0.7)
	var clouds_weight = randf_range(0,1)
	
	print(clouds_cutoff," ",clouds_weight)
	env.clouds_cutoff =clouds_cutoff #lerp(env.clouds_cutoff,clouds_cutoff,delta*2)
	env.clouds_weight =clouds_weight #lerp(env.clouds_weight,clouds_weight,delta*2)
	env._update_clouds()
	if clouds_cutoff > 0.30:
		rain = false
		heavy_rain = false
	if clouds_cutoff < 0.30 and clouds_weight < 0.30:
		var rnd = randi_range(1,2)
		if rnd == 1:
			rain = true
	if clouds_weight > 0.30 and clouds_cutoff < 0.30:
		rain = true
		heavy_rain = true
	pass # Replace with function body.
