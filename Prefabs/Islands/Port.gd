extends Node3D
class_name Port

var entered : bool = true
@export var ship_point : Marker3D
@export var ship_camera : Node3D
@export var ship_camera_2 : Node3D
var interacted : bool = false;
@export var ui_scene : PackedScene
var opened : bool = false;
var obj
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_ui():
	Global.ui.temp.visible = true;
	obj = ui_scene.instantiate()
	Global.current_window = obj;
	Global.ui.temp.add_child(obj)
	opened = true;
func show_ui_shop():
	show_ui()
	obj.enable_shop()
	change_camera_to_ship()
	pass


func show_ui_tavern():
	show_ui()
	obj.enable_tavern()
	change_camera_to_ship()
	
func destroy_ui():
	opened = false;
	print(obj)
	if obj  != null:
		obj.queue_free()
	
func change_camera_to_ship():
	Global.player.global_position = Vector3(ship_point.global_position.x, Global.player.global_position.y, ship_point.global_position.z)
	Global.player.rotation = ship_point.rotation
	Global.camera.target_follow = ship_camera_2
	
func change_camera_to_island():
	Global.player.global_position = Vector3(ship_point.global_position.x, Global.player.global_position.y, ship_point.global_position.z)
	Global.player.rotation = ship_point.rotation
	Global.camera.target_follow = ship_camera
	
func _physics_process(delta):
	if entered:
		if Input.is_action_just_pressed("Interact"):
			if !interacted:
				Global.ui.temp.visible = false;
				Signals.emit_signal("player_entered_port")
				Global.player.stop_movement = true;
				Global.player.global_position = Vector3(ship_point.global_position.x, Global.player.global_position.y, ship_point.global_position.z)
				Global.player.rotation = ship_point.rotation
				Global.camera.target_follow = ship_camera
				interacted = true
			else:
				destroy_ui()
				Signals.emit_signal("player_exited_port")
				Global.player.stop_movement = false;
				Global.camera.target_follow = Global.camera.default_camera
				interacted = false
			print("Enter port")
