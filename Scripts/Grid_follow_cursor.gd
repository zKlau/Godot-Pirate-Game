extends MeshInstance3D

var mouse
var fog_hole = preload("res://Prefabs/fog_hole.tscn")
var selected_ship
var ship_menu_over : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.cursor = self
	Signals.connect("ship_menu_closed",close_ship_menu)
	pass # Replace with function body.

func close_ship_menu():
	selected_ship = null


func _input(event):
	if event is InputEventMouse and Global.cursor_click_ship:
		mouse = event.position
		get_cursor_position(event)
		
	if %"MATCH GAME".player1_turn:
		if event is InputEventMouseButton and event.pressed:
			var worldspace = get_world_3d().direct_space_state
			var start = Global.camera.project_ray_origin(mouse)
			var end = Global.camera.project_position(mouse, 10000)
			var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
		#print(result.collider.get_parent().name)
			#var obj = fog_hole.instantiate()
			#get_tree().root.add_child(obj)
			#obj.global_position = global_position
			#$"..".camera_animation.play("go_to_player_camera")
					
	#if event is InputEventMouseButton and event.pressed:
	#	if event.button_index == MOUSE_BUTTON_LEFT:
			
# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_cursor_position(event):
	var worldspace = get_world_3d().direct_space_state
	var start = Global.camera.project_ray_origin(mouse)
	var end = Global.camera.project_position(mouse, 10000)
	var result = worldspace.intersect_ray(PhysicsRayQueryParameters3D.create(start, end))
	if result:
		if event is InputEventMouse:
			mouse = event.position
		if event is InputEventMouseButton and event.pressed  and ship_menu_over == false:
			if "Ship" in result.collider.get_parent().name:
				if event.button_index == MOUSE_BUTTON_LEFT and selected_ship != result.collider.get_parent():
					interact(result.collider.get_parent())
					selected_ship = result.collider.get_parent()
						#print(result.collider.get_parent().name)
							#get_selection()
			if "FloatingObject" in result.collider.get_parent().name:
				result.collider.get_parent().interact()
	'''
	if roundi(result.position.x) % 2 != 0:
		global_position.x = roundi(result.position.x)
	if roundi(result.position.z) % 2 != 0:
		global_position.z = roundi(result.position.z)
	#print(roundi(result.position.x)," ",roundi(result.position.z))
	'''
	
func interact(ship):
	ship.interact()
	pass
func _process(delta):
	pass
