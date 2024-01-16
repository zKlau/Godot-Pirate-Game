extends Control

var camera_r : bool = true
@onready var anim : AnimationPlayer = $UI_Animations
var menu_opened : bool = false

@onready var titles = $Titles
@export var temp : Control
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.ui = self;
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


func _input(event):
	if event.is_action_pressed("escape"):
		menu()
func menu():
	if !menu_opened:
		get_tree().paused = true
		anim.play("Menu_IN")
		menu_opened = true
	else:
		resume()
func resume():
	get_tree().paused = false
	anim.play("Menu_OUT")
	menu_opened = false
func _on_menu_button_pressed():
	Signals.emit_signal("ship_menu_opened")
	menu()
	pass # Replace with function body.
