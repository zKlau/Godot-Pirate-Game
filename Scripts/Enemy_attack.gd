extends Node3D

var cube = preload("res://Prefabs/cube.tscn")
var previous_points = []
var attacks_this_round : int = 0

var attack_coords_array = []
var current_ship : int = 0
var rnd_point : Vector2
var coords : Vector3
var attack_position : Vector2

var total_cells : int
# Called when the node enters the scene tree for the first time.
func _ready():
	var x_dist = round($Top_left.global_position.distance_to($Top_right.global_position)/2)+1
	var y_dist = round($Bottom_left.global_position.distance_to($Top_left.global_position)/2)+1
	total_cells = x_dist * y_dist
	print(x_dist," ", y_dist," ", )
	Signals.connect("new_round",new_round)
	
	pass # Replace with function body.

func new_round():
	current_ship = 0
func generate_random_point():
	rnd_point =  Vector2(randi_range($Top_left.global_position.x, $Top_right.global_position.x), randi_range($Top_right.global_position.z, $Bottom_right.global_position.z))
	while roundi(rnd_point.x) % 2 == 0:
		rnd_point.x = randi_range($Top_left.global_position.x, $Top_right.global_position.x)
	while roundi(rnd_point.y) % 2 == 0:
		rnd_point.y = randi_range($Top_left.global_position.z, $Bottom_left.global_position.z)
	if rnd_point in previous_points:
		print("copy point")
		generate_random_point()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if len(previous_points) > total_cells * 0.4:
		previous_points = []
	if %"MATCH GAME".player2_turn and %"MATCH GAME".p2_round_attacks == 0:
		%"MATCH GAME".prepare_next_round()
	if !%"MATCH GAME".player1_turn and %"MATCH GAME".player2_turn and %"MATCH GAME".p2_round_attacks > 0:
		%"MATCH GAME".p2_round_attacks -= 1
		generate_random_point()
		#while rnd_point in previous_points:
		#	generate_random_point()
		if true:
			previous_points.append(rnd_point)
			
			var space_state = get_world_3d().direct_space_state
			var query = PhysicsRayQueryParameters3D.create( Vector3(rnd_point.x, 50 ,rnd_point.y), Vector3(rnd_point.x, -10, rnd_point.y))
			var result = space_state.intersect_ray(query)
			#if result:
				#print(result.collider.get_parent().name)
			if %"MATCH GAME".player2_ships[current_ship].attack_coords == Vector3():
				print("normal vector")
				attack_position = Vector2(rnd_point.x,rnd_point.y)
				coords = Vector3(rnd_point.x,1,rnd_point.y)
				%"MATCH GAME".player2_ships[current_ship].attack_coords = coords
			else:
				print("dupe")
				attack_position = Vector2(%"MATCH GAME".player2_ships[current_ship].attack_coords.x,%"MATCH GAME".player2_ships[current_ship].attack_coords.y)
				coords = %"MATCH GAME".player2_ships[current_ship].attack_coords#%"MATCH GAME".player2_ships[current_ship].attack_coords
			
			attack_coords_array.append(coords)
			attacks_this_round -= 1
			current_ship += 1
			#%"MATCH GAME".player2_turn = false
		#$"..".camera_animation.play("go_to_enemy_camera")
			attack()
	#if %"MATCH GAME".player2_turn and %"MATCH GAME".p2_round_attacks == 0:
		
	pass

func attack():
	#print("attack ",attack_coords_array)
	'''
	for ship in %"MATCH GAME".player2_ships:
		var loc = ship.attack_coords
		
		#loc.x = -89
		#loc.z = -11
		var obj = cube.instantiate()
		get_tree().root.add_child(obj)
		obj.global_position.x = loc.x
		obj.global_position.y = loc.y
		obj.global_position.z = loc.z
		%"MATCH GAME".check_hit_zone(Vector2(loc.x,loc.z),0,CannonBalls.ball_type(ship.cannon_ball) * (ship.cannons+1),ship.cannon_ball)
		#print("test")
	'''
	%"MATCH GAME".summon_attack(%"MATCH GAME".player2_ships,0,attack_coords_array,cube)
	%"MATCH GAME".player2_turn = false
	#%"MATCH GAME".camera_animation.play("go_to_enemy_camera")
	attack_coords_array = []
	%"MATCH GAME".prepare_next_round()
