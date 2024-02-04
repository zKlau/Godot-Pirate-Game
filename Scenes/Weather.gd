extends Node

var player
@export var rain : bool = false
@onready var rain_particles : GPUParticles3D = $Rain
@export var heavy_rain : bool = false
@export var rain_weight : int = 4000
@onready var env : Node = $".."
@export var wind_timer : int = 160
var time : float = 0;
func _ready():
	player = Global.player
	pass
	
func _process(delta):
	time += delta
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
		Global.wind = randi_range(1,5)
		wind_timer *= randi_range(1.5,2.2)
		match Global.wind:
			1: # north
				%wind_direction.text = "Wind: North"
				Global.north_wind = 1.2
				Global.east_wind = 0.95
				Global.west_wind = 0.95
				Global.south_wind = 0.8
			2: #south
				%wind_direction.text = "Wind: South"
				Global.north_wind = 0.8
				Global.east_wind = 0.95
				Global.west_wind = 0.95
				Global.south_wind = 1.2
			3: #east
				%wind_direction.text = "Wind: East"
				Global.north_wind = 0.95
				Global.east_wind = 1.2
				Global.west_wind = 0.8
				Global.south_wind = 0.95
			4: #west
				%wind_direction.text = "Wind: West"
				Global.north_wind = 0.95
				Global.east_wind = 0.8
				Global.west_wind = 1.2
				Global.south_wind = 0.95
			5: # none
					%wind_direction.text = "Wind: None"
					Global.north_wind = 1
					Global.east_wind = 1
					Global.west_wind = 1
					Global.south_wind = 1
			
	
	pass
func _on_rain_timer_timeout():
	var clouds_cutoff = randf_range(0,1)
	var clouds_weight = randf_range(0,1)
	
	env.clouds_cutoff = lerp(env.clouds_cutoff,clouds_cutoff,time*2)
	env.clouds_weight = lerp(env.clouds_weight,clouds_weight,time*2)
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
