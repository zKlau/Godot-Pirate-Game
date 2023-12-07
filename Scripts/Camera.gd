extends Camera3D

@export var target_follow : Node3D
@export var follow_offset : float = 0
@export var follow_speed : float = 5
@export var follow_rotation_speed : float = 10
@export var action_camera_left : Node3D
@export var action_camera_right : Node3D
var default_camera : Node3D
var current_camera : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	default_camera = target_follow
	Global.camera = self
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("Switch Camera"):
		match current_camera:
			0:
				target_follow = action_camera_right
				current_camera = 1
			1:
				target_follow = action_camera_left
				current_camera = 2
			2:
				target_follow = default_camera
				current_camera = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_follow != null:
		position.x = lerp(position.x, target_follow.global_position.x+follow_offset,delta*follow_speed)
		position.z = lerp(position.z, target_follow.global_position.z+follow_offset,delta*follow_speed)
		position.y = lerp(position.y, target_follow.global_position.y+follow_offset,delta*follow_speed)
		rotation.y = lerp_angle(rotation.y, target_follow.global_rotation.y, delta*follow_rotation_speed)
			
	pass
