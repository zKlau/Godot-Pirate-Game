extends Node

var player
@export var rain : bool = false
@onready var rain_particles : GPUParticles3D = $Rain
@export var heavy_rain : bool = false
var rain_weight : int = 2000
@onready var env : Node = $".."
var time
func _ready():
	
	player = Global.player
	pass
	
func _process(delta):
	time = delta
	if rain:
		if !$"Rain/Light Rain".playing:
			$"Rain/Light Rain".play()
		rain_particles.position.x = Global.player.global_position.x
		rain_particles.position.z = Global.player.global_position.z
		if heavy_rain:
			rain_particles.amount = rain_weight*2
		rain_particles.emitting = true
	else:
		$"Rain/Light Rain".stop()
		rain_particles.amount = rain_weight*2
		rain_particles.emitting = false
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
