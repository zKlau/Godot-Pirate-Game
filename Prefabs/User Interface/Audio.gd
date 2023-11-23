extends Control

@export var settings : Settings
# Called when the node enters the scene tree for the first time.
func _ready():
	settings = $"../..".settings
	load_settings()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func load_settings():
	$"Master Audio/Level".text = str(linear_transform(settings.master_volume))+"%"
	$"Master Audio/Master_slider".value = settings.master_volume
	$"Sound Effects/Level".text = str(linear_transform(settings.effects_volume))+"%"
	$"Sound Effects/Sound_effects_slider".value = settings.effects_volume
	$Music/Level.text = str(linear_transform(settings.music_volume))+"%"
	$Music/Music_slider.value = settings.music_volume
	pass
func save_settings():
	ResourceSaver.save(settings,"res://Data/Settings/Settings.tres");
	pass

func linear_transform(x):
	var min = -40
	x = max(min, min(x, 0))
	return floor(((x - min) / (0 - min)) * 100)

func _on_master_slider_value_changed(value):
	$"Master Audio/Level".text = str(linear_transform(value))+"%"
	AudioServer.set_bus_volume_db(0,value)
	settings.master_volume = value
	$"../..".save_settings()
	pass # Replace with function body.


func _on_sound_effects_slider_value_changed(value):
	$"Sound Effects/Level".text = str(linear_transform(value))+"%"
	AudioServer.set_bus_volume_db(2,value)
	settings.effects_volume = value
	$"../..".save_settings()
	pass # Replace with function body.


func _on_music_slider_value_changed(value):
	$Music/Level.text = str(linear_transform(value))+"%"
	AudioServer.set_bus_volume_db(1,value)
	settings.music_volume = value
	$"../..".save_settings()
	pass # Replace with function body.
