extends Node
class_name EventSeagulls

@export var scene : PackedScene
@export var spawn_time_min : float = 120
@export var spawn_time_max : float = 180
var current_events
var spawn_time : float
var time : float
func _init():
	pass

func timer():
	spawn_time = randf_range(spawn_time_min,spawn_time_max)
	
func _physics_process(delta):
	time += delta;
	if time > spawn_time:
		spawn_event()
		time = 0;
		timer()
		
func spawn_event():
	var obj = scene.instantiate()
	get_tree().root.get_node("World").add_child(obj)
	obj.global_position = Global.player.global_position
	obj.global_position.y = 3.682
	obj.rotation = Global.player.rotation
	get_parent().current_events.append(obj)

func _input(event):
	if event.is_action_pressed("event"):
		var obj = scene.instantiate()
		get_tree().root.get_node("World").add_child(obj)
		obj.global_position = Global.player.global_position
		obj.global_position.y = 3.682
		obj.rotation = Global.player.rotation
		get_parent().current_events.append(obj)
