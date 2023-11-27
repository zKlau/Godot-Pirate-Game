@icon("res://addons/boujie_water_shader/icons/Wave.svg")
class_name GerstnerWave
extends Resource

@export var steepness := 1.0
@export var amplitude := 1.0
@export_range(0, 360) var direction_degrees := 0.0
@export var frequency := 0.1
@export var speed := 1.0
@export_range(0, 360) var phase_degrees := 0.0


func P_DEG(x,y,z,t):
	var Direction = Vector2( sin(direction_degrees * TAU / 360.0), cos(direction_degrees * TAU / 360.0 ));
	var p = phase_degrees * TAU / 360.0
	var result = Vector3(0,0,0);
	result.x = ((steepness * amplitude) * Direction.x * cos(TAU * (frequency * Direction).dot(Vector2(x, z)) + (speed * (t+p))));
	result.y = steepness * sin(TAU * (frequency * Direction).dot(Vector2(x, z)) + (speed * (t+p)));
	result.z = ((steepness * amplitude) * Direction.y * cos(TAU * (frequency * Direction).dot(Vector2(x, z)) + (speed * (t+p))));
	
	return result;
