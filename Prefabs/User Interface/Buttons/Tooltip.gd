extends Control

#@export var background_texture : Texture
@onready var description = $PanelContainer/Description
@onready var background = $Background
@export var label_teture : Texture2D

func set_text(text : String):
	description.text = text
	
func _process(delta):
	if background.scale.y != 0.0005 * description.size.y and len(description.text) != 0:
		background.scale.y = 0.0005 * description.size.y + 0.016
	


func _on_area_2d_mouse_entered():
	background.scale.y = 0.0005 * description.size.y + 0.016
	print(description.size.y)
	background.visible = true
	description.visible = true
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	background.visible = false
	description.visible = false
	pass # Replace with function body.
