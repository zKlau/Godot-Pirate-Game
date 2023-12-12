extends Node3D
class_name Ship_Casts

var casts : Array[RayCast3D]
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in get_children():
		casts.append(i)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
