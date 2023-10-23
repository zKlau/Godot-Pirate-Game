extends Control

#@export var background_texture : Texture
@onready var description = $Description
@onready var background = $Background

func set_text(text : String):
	description.text = text


func _on_area_2d_mouse_entered():
	#background.texture = background_texture
	background.visible = true
	description.visible = true
	#description.text = get_parent().ability.description
	print("mouse entered the ebility slot")
	pass # Replace with function body.


func _on_area_2d_mouse_exited():
	background.visible = false
	description.visible = false
	pass # Replace with function body.
