extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	print("Player entered the island zone " , body)
	#print(Global.ocean.material.get("shader_parameter/WaveSteepnesses"))
	Global.water.height_waves[0].steepness = 0.001;
	pass # Replace with function body.


func _on_body_exited(body):
	Global.water.height_waves[0].steepness = 2;
	print(Global.water.height_waves[0].steepness)
	pass # Replace with function body.
