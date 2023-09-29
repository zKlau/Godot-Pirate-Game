extends Sprite2D

var mark = preload("res://Scenes/mark.tscn")
@export var show = true
# Called when the node enters the scene tree for the first time.
func _ready():
	#display_map(show)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func display_map(state : bool):
	visible = state


func _on_map_button_pressed():
	display_map(!visible)
	pass # Replace with function body.
