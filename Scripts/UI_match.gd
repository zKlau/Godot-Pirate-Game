extends Control

var camera_r : bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if len(%"MATCH GAME".player1_ships) > 0:
	#	$Current_Ship_Selected.text = str(%"MATCH GAME".player1_ships[%Player_attack_zone.current_ship]._name)
	pass


func _on_switch_camera_pressed():
	if camera_r:
		camera_r = false
		Global.rotate_camera(90)
	else:
		Global.rotate_camera(0)
		camera_r = true
	pass # Replace with function body.
