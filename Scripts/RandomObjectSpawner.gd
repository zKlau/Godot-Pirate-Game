extends Node3D

@export var objects : Array[Random_object_data_currency]
@export var spawn_object : PackedScene
@onready var left_point = $Left
@onready var right_point = $Right

@export var min_time = 30
@export var max_time = 60
var spawn_time
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_time = randf_range(min_time,max_time)
	#timer.wait_time = spawn_object
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass


func choose_object():
	print("spawn")
	var rnd = randi_range(0,len(objects)-1)
	var obj = objects[rnd]
	var chance = randi_range(0,100)
	if chance <= obj.chance:
		var spw = spawn_object.instantiate()
		spw.main_ = %"MATCH GAME"
		spw.name = "FloatingObject " + str(randi())
		get_tree().root.get_node("Game").add_child.call_deferred(spw)
		spw.set_owner(%"MATCH GAME".get_parent())
		spw.enable_phisycs()
		print(left_point.position.x)
		var random_position_x = randf_range(left_point.global_position.x,right_point.global_position.x)
		#var random_position_z = randf_range(left_point.global_position.z,right_point.global_position.z)
		spw.global_position = Vector3(random_position_x,0,0)
		spw.reward = obj
		return
	else:
		choose_object()


func _on_timer_timeout():
	choose_object()
	spawn_time = randf_range(min_time,max_time)
	timer.wait_time = spawn_time
	pass # Replace with function body.
