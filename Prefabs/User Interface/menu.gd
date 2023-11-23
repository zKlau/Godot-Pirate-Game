extends Control

@export var settings : Settings
# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
	pass # Replace with function body.

func load_settings():
	AudioServer.set_bus_volume_db(0,settings.master_volume)
	AudioServer.set_bus_volume_db(1,settings.music_volume)
	AudioServer.set_bus_volume_db(0,settings.effects_volume)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func save_settings():
	ResourceSaver.save(settings,"res://Data/Settings/Settings.tres");
	pass


func _on_resume_pressed():
	get_parent().resume()
	pass # Replace with function body.


func _on_options_pressed():
	$Options.visible = true
	$Menu.visible = false
	pass # Replace with function body.


func _on_audio_pressed():
	$Options/Audio.visible = true
	$Options/VBoxContainer.visible = false
	pass # Replace with function body.


func _on_audio_back_pressed():
	$Options/Audio.visible = false
	$Options/VBoxContainer.visible = true
	pass # Replace with function body.


func _on_options_back_pressed():
	$Options.visible = false
	$Menu.visible = true
	pass # Replace with function body.
