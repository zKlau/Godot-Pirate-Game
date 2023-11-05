extends Camera3D

@export var target_follow : Node3D
@export var follow_offset : float = 10
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.camera = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_follow != null:
		position.x = lerp(position.x, target_follow.global_position.x+follow_offset,delta*10)
		position.z = lerp(position.z, target_follow.global_position.z+follow_offset,delta*10)
	pass
