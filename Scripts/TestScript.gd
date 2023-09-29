extends MeshInstance3D

var hover : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if hover:
		if event is InputEventMouseButton and event.pressed:
			print("test")
	pass

func interact():
	print("interacted")



func _on_static_body_3d_mouse_entered():
	hover = true
	pass # Replace with function body.


func _on_static_body_3d_mouse_exited():
	hover = false
	pass # Replace with function body.
