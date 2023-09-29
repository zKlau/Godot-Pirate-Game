@tool
extends Node2D

var selected = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$mark.rotation = randf_range(-10,10)
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_mouse_entered():
	$Grid.visible = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	$Grid.visible = false
	pass # Replace with function body.


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		selected = true
	pass # Replace with function body.

func _physics_process(delta):
	if selected:
		attack_location()
		selected = false
		pass
func attack_location():
	if %"MATCH GAME".p1_round_attacks > 0:
		$mark.visible = true
		#print(get_index(),name)
		Signals.emit_signal("player_attack_location",get_index())
	pass
