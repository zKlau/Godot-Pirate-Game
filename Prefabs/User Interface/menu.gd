extends Control

@export var settings : Settings
# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
	pass # Replace with function body.

func load_settings():
	AudioServer.set_bus_volume_db(0,settings.master_volume)
	AudioServer.set_bus_volume_db(1,settings.music_volume)
	AudioServer.set_bus_volume_db(2,settings.effects_volume)

	if settings.vsync == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	if settings.display_mode == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	match settings.scaling_mode:
		1:
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_BILINEAR
			#get_viewport().scaling_3d_scale = 1
		2:
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_FSR
			#get_viewport().scaling_3d_scale = 0.77
		3:
			get_viewport().scaling_3d_mode = Viewport.SCALING_3D_MODE_FSR2
			#get_viewport().scaling_3d_scale = 0.67
	get_viewport().scaling_3d_scale = settings.scaling_value
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


func _on_graphics_back_pressed():
	$Options/Graphics.visible = false
	$Options/VBoxContainer.visible = true
	pass # Replace with function body.


func _on_graphics_pressed():
	$Options/Graphics.visible = true
	$Options/VBoxContainer.visible = false
	pass # Replace with function body.


func _on_save_exit_pressed():
	Signals.emit_signal("quit_game")
	Signals.emit_signal("save_game")
	get_tree().quit()
	pass # Replace with function body.
