extends Node

var current_events : Array[Node3D]
'''
func _physics_process(delta):
	
	for i in current_events:
		if i.global_position.distance_to(Global.player.global_position) > 300:
			current_events.remove_at(current_events.find(i))
			i.free()
'''		
