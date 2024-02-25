extends Camera3D

@export var target_follow : Node3D
@export var follow_offset : float = 0
@export var follow_speed : float = 5
@export var follow_rotation_speed : float = 10
@export var action_camera_left : Node3D
@export var action_camera_right : Node3D
var default_camera : Node3D
var current_camera : int = 0

var ssCount : int = 1;
# Called when the node enters the scene tree for the first time.
func _ready():
	default_camera = target_follow
	Global.camera = self
	var dir = DirAccess.open("user://")
	dir.make_dir("screenshots")
	
	dir = DirAccess.open("user://screenshots")
	for n in dir.get_files():
		ssCount += 1
	pass # Replace with function body.


func _input(event):
	'''
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
	'''
	if event.is_action_pressed("Screenshot"):
		screenshot()
	if event.is_action_pressed("1"):
		target_follow = default_camera
		current_camera = 0
	if event.is_action_pressed("3"):
		target_follow = action_camera_left
		current_camera = 2
	if event.is_action_pressed("2"):
		target_follow = action_camera_right
		current_camera = 1
		
func screenshot():
	await RenderingServer.frame_post_draw
	
	var viewport = get_viewport()
	var img = viewport.get_texture().get_image()
	img.save_png("user://screenshots/screen"+str(ssCount)+".png")
	
	ssCount += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target_follow != null:
		position.x = lerp(position.x, target_follow.global_position.x+follow_offset,delta*follow_speed)
		position.z = lerp(position.z, target_follow.global_position.z+follow_offset,delta*follow_speed)
		position.y = lerp(position.y, target_follow.global_position.y+follow_offset,delta*follow_speed)
		rotation.y = lerp_angle(rotation.y, target_follow.global_rotation.y, delta*follow_rotation_speed)
			
	pass
