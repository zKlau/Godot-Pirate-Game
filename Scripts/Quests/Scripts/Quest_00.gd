extends Node3D

@export var points : Resource

func _ready():
	Signals.connect("save_game",save_game)
	if points.area1_completed:
		$"Area 1".queue_free()
	if points.area2_completed:
		$"Area 2".queue_free()
	if points.area3_completed:
		$"Area 3".queue_free()
	if points.area4_completed:
		$"Area 4".queue_free()
	if points.area5_completed:
		$"Area 5".queue_free()
	pass # Replace with function body.
func save_game():
	ResourceSaver.save(points,"res://Data/Quests/Data/Quest_00.tres")
	
func _on_area_1_body_entered(body):
	points.area1_completed = true;
	print("area 1 entered")
	$"Area 1".queue_free()
	Signals.emit_signal("save_game")
	pass # Replace with function body.


func _on_area_4_body_entered(body):
	points.area4_completed = true;
	print("area 4 entered")
	$"Area 4".queue_free()
	Signals.emit_signal("save_game")
	pass # Replace with function body.


func _on_area_2_body_entered(body):
	points.area2_completed = true;
	print("area 2 entered")
	$"Area 2".queue_free()
	Signals.emit_signal("save_game")
	pass # Replace with function body.


func _on_area_3_body_entered(body):
	points.area3_completed = true;
	print("area 3 entered")
	$"Area 3".queue_free()
	Signals.emit_signal("save_game")
	pass # Replace with function body.


func _on_area_5_body_entered(body):
	points.area5_completed = true;
	print("area 5 entered")
	$"Area 5".queue_free()
	Signals.emit_signal("save_game")
	pass # Replace with function body.
