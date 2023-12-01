extends Control

@onready var main =  $"../.."
var resolutions = [Vector2i(640,360), 
						Vector2i(854,480),
						Vector2i(960,540),
						Vector2i(1024,576),
						Vector2i(1280,720),
						Vector2i(1366,768),
						Vector2i(1600,900),
						Vector2i(1920,1080),
						Vector2i(2560,1440), 
						Vector2i(3200,1800), 
						Vector2i(3840,2160),
						Vector2i(5120,2880),
						Vector2i(7680,4320)]
# Called when the node enters the scene tree for the first time.
func _ready():
	load_settings()
	display_resolution()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func load_settings():
	$vSync/CheckButton.button_pressed = main.settings.vsync
	if main.settings.vsync == true:
		$vSync/Status.text = "ON"
	else:
		$vSync/Status.text = "OFF"
	if main.settings.display_mode == 1:
		$DisplayMode/DisplayMode_selection.selected = 1
	else:
		$DisplayMode/DisplayMode_selection.selected = 0
	DisplayServer.window_set_size(resolutions[main.settings.resolution])
func _on_check_button_toggled(button_pressed):
	if button_pressed == true:
		$vSync/Status.text = "ON"
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		main.settings.vsync = true
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		main.settings.vsync = false
		$vSync/Status.text = "OFF"
	main.save_settings()
	print(button_pressed)
	pass # Replace with function body.


	pass # Replace with function body.

func display_resolution():
	var num_steps = 5
	var max_size = DisplayServer.screen_get_size()
	
	if resolutions.find(max_size) >= -1:
		for i in range(resolutions.find(max_size)+1):
			$Resolution/DisplayResolution_selection.add_item(str(resolutions[i][0]) + "x" + str(resolutions[i][1]))

func _on_display_mode_selection_item_selected(index):
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		main.settings.display_mode = 0
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		main.settings.display_mode = 1
	main.save_settings()
	pass # Replace with function body.


func _on_display_resolution_selection_item_selected(index):
	DisplayServer.window_set_size(resolutions[index])
	main.settings.resolution = index
	main.save_settings()
	pass # Replace with function body.
