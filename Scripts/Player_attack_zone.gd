extends Node3D

@onready var attack_coords = $Top_left.global_position
var fog_hole = preload("res://Prefabs/fog_hole.tscn")
@onready var anim = $AnimationPlayer
var attacks_this_round : int = 0

var attack_coords_array = []
var current_ship : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("player_attack_location",attack_location)
	Signals.connect("player1_attack",spawn_attack)
	Signals.connect("new_round",new_round)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func new_round():
	current_ship = 0
	
func attack_location(location):
	while %"MATCH GAME".player1_ships[current_ship].can_attack == false:
		print(%"MATCH GAME".player1_ships[current_ship]._name," atacck")
		current_ship += 1
	%"MATCH GAME".p1_round_attacks -= 1
	attack_coords = $Top_left.global_position
	attack_coords.y = 1
	var temp_x = attack_coords.x
	for i in range(1,location+1):
		if i % 16 == 0 and i != 0:
			temp_x = attack_coords.x
			attack_coords.z += 2
			continue
		temp_x += 2
	attack_coords.x = temp_x
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create( Vector3(attack_coords.x, 50 ,attack_coords.y), Vector3(attack_coords.x, -10, attack_coords.y))
	query.collide_with_areas = true
	query.collide_with_bodies = false
	var result = space_state.intersect_ray(query)
	if result:
		print(result.collider.get_parent().name)
	var coords = Vector3(attack_coords.x,attack_coords.y,attack_coords.z)
	%"MATCH GAME".player1_ships[current_ship].attack_coords = coords
	attack_coords_array.append(coords)
	print(attack_coords_array)
	#print(current_ship)
	#anim.play("attack")
	#%"MATCH GAME".check_hit_zone(Vector2(attack_coords.x,attack_coords.z),1,10)
	if current_ship < len(%"MATCH GAME".player1_ships)-1:
		current_ship += 1
func spawn_attack():
	print("player attack")
	'''
	for ship in %"MATCH GAME".player1_ships:
		if ship.attack_stopped_for == 0 and ship.attack_coords in attack_coords_array:
			print(ship.name,ship.attack_coords)
			var loc = ship.attack_coords
			if ship.cannons == 2:
				ship.attack_stopped_for = 2
			if ship.cannons == 3:
				print("3 cannons")
				ship.attack_stopped_for = 4
			
			%"MATCH GAME".check_hit_zone(Vector2(loc.x,loc.z),1,CannonBalls.ball_type(ship.cannon_ball) * (ship.cannons+1),ship.cannon_ball)
			
			var obj = fog_hole.instantiate()
			get_tree().root.add_child(obj)
			obj.global_position = loc
			ship.attack_coords = Vector3()
	'''
	%"MATCH GAME".summon_attack(%"MATCH GAME".player1_ships,1,attack_coords_array,fog_hole)
	#print(%"MATCH GAME".p1_round_attacks)
	#%"MATCH GAME".camera_animation.play("go_to_player_camera")
	attack_coords_array = []
