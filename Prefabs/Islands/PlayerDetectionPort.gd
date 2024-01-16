extends Area3D

@export var parent : Port
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	Global.ui.titles.enter_port.visible = true
	parent.entered = true
	pass # Replace with function body.


func _on_body_exited(body):
	Global.ui.titles.enter_port.visible = false
	parent.entered = false
	pass # Replace with function body.
