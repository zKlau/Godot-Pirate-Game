extends Node
var camera
var mouse_action = true
var cursor_click_ship = true
var water
var m_game
var cursor
var player
var allow_ship_interaction : bool = true
# Called when the node enters the scene tree for the first time.


func rotate_camera(rot):
	match rot:
		0:
			m_game.camera_anim.play("to_player")	
		90:
			m_game.camera_anim.play("to_enemy")
	#Signals.emit_signal("ship_menu_opened")
	#var r = (rot*3)/90
	#camera.rotation = Vector3(0,r,0)
