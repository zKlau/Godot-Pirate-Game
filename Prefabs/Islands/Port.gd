extends Node3D
class_name Port

var entered : bool = true
@export var ship_point : Marker3D
@export var ship_camera : Node3D
var interacted : bool = false;
@export var ui_scene : PackedScene
var obj
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_ui():
	obj = ui_scene.instantiate()
	Global.ui.temp.add_child(obj)
	pass

func destroy_ui():
	obj.queue_free()
	
func _physics_process(delta):
	if entered:
		if Input.is_action_just_pressed("Interact"):
			if !interacted:
				show_ui()
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
