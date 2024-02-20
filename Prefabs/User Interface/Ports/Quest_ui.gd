extends Control

@export var dialogues : Dialogue_Data
@onready var dialogue_interface : PackedScene = preload("res://Prefabs/User Interface/Dialogue/dialogue.tscn")
@export_range(100,500) var text_speed : float 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_accept_pressed():
	Global.current_island.change_camera_to_island()
	Global.current_island.opened = false;
	Global.ui.temp_distroy_ui()
	Global.ui.show_temp_diag(dialogue_interface)
	Global.current_dialogue.display_text(dialogues, text_speed)
	pass # Replace with function body.
