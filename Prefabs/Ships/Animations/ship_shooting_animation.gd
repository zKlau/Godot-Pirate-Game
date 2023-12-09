extends Node3D

@onready var anim = $Anim
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().shooting_animation = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
