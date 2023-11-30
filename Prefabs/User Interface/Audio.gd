extends Control

@export var settings : Settings
@export var min : int = -30
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
	x = max(min, min(x, 0))
	return floor(((x - min) / (0 - min)) * 100)

func set_audio(value,id):
	AudioServer.set_bus_volume_db(id,value)
	if value <= min:
		AudioServer.set_bus_mute(id, true)
	else:
		AudioServer.set_bus_mute(id, false)
func _on_master_slider_value_changed(value):
	$"Master Audio/Level".text = str(linear_transform(value))+"%"
	set_audio(value,0)
	settings.master_volume = value
	$"../..".save_settings()
	pass # Replace with function body.


func _on_sound_effects_slider_value_changed(value):
	$"Sound Effects/Level".text = str(linear_transform(value))+"%"
	set_audio(value,2)
	settings.effects_volume = value
	$"../..".save_settings()
	pass # Replace with function body.


func _on_music_slider_value_changed(value):
	$Music/Level.text = str(linear_transform(value))+"%"
	set_audio(value,1)
	settings.music_volume = value
	$"../..".save_settings()
	pass # Replace with function body.
