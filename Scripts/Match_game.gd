extends Node

var match_started : bool = false

var player1_turn : bool = true
var player2_turn : bool = false


var player1_attacked = false
#@onready var camera_animation = $"../Cameras/AnimationPlayer"

var player1_ships = []
var player2_ships = []

@export var player_data : Player_Data

var round : int = 0
var current_attacker : int = 0 # Player1 = 0  |   Player2 = 1

var player1_attacks : int
var player2_attacks : int

var p1_round_attacks : int
var p2_round_attacks : int

func set_player_turn(state :bool):
	player1_turn = state
func set_enemy_turn(state :bool):
	player2_turn = state
func go_to_player_after_attack():
	pass
	#camera_animation.play("go_to_player_camera")
func go_to_enemy_after_attack():
	#camera_animation.play("go_to_enemy_camera")
	pass
var default_ships_player1 = []
var default_ships_player2 = []

var selected_player_ship : Ship = null
var selected_enemy_ship : Ship = null

@onready var attack_button = $"../UI/Attack Button"
@onready var camera_anim : AnimationPlayer = $Camera
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("attack_button",attack_button_pressed)
	Global.m_game = self
	#load_player()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var ai_att_time = 0
var move_e_camera : bool = false
func _process(delta):
	
	if p2_round_attacks == player2_attacks and p1_round_attacks == player1_attacks:
		#$"../UI/Attack Button".visible = false
		$"../UI/Next Round".visible = true
		#print("round complete") 
	if Global.allow_ship_interaction == false and player2_turn:
		ai_att_time += delta
		if move_e_camera == false:
			Global.rotate_camera(0)
			move_e_camera = true
		if ai_att_time >= 2:
			if p2_round_attacks < player2_attacks:
				for ship in player2_ships:
					print("enemy ai attacking")
				#var rnd_ship = randi_range(0,len(player2_ships)-1)
				#print(player2_ships[rnd_en_ship]._name)
					selected_player_ship = ship#player2_ships[rnd_en_ship]
					var iter_ships = 0
					var rnd_p_ship = randi_range(0,len(default_ships_player1)-1)
					while default_ships_player1[rnd_p_ship].health < 0 and iter_ships <= len(default_ships_player1):
						iter_ships += 1
						rnd_p_ship = randi_range(0,len(default_ships_player1)-1)
					if iter_ships > len(default_ships_player1):
						print("The ENEMY HAS WON")
					selected_enemy_ship = default_ships_player1[rnd_p_ship]
					attack(1)
					ai_att_time = 0
				player2_turn = false
				move_e_camera = false
	if Input.is_action_pressed("1"):
		save_player()
	#if selected_player_ship != null and selected_enemy_ship != null:
	#	attack_button.visible = true
	pass

func add_default_ships(player : int,ship : Ship):
	match player:
		0:
			default_ships_player1.append(ship)
		1:
			default_ships_player2.append(ship)

func new_round():
	Global.rotate_camera(0)
	#load_player()
	player1_ships = []
	player2_ships = []
	await Signals.emit_signal("new_round")
	await get_tree().create_timer(0.5).timeout
	for i in range(1,len(player1_ships)-1):
		for x in range(0,len(player1_ships)-1):
			if player1_ships[x+1].id < player1_ships[x].id:
				var temp = player1_ships[x]
				player1_ships[x] = player1_ships[x+1]
				player1_ships[x+1] = temp 
	
	p1_round_attacks = 0
	p2_round_attacks = 0
	player1_attacks = 0
	player2_attacks = 0
	# Check if ship can attack--
	for ship in player1_ships:
		if ship.attack_stopped_for == 0:
			ship.id = player1_ships.find(ship)
			player1_attacks += 1
			#print(ship._name, " new ship added")
		else:
			pass
			#print(ship._name)
	for ship in player2_ships:
		if ship.attack_stopped_for == 0:
			ship.id = player2_ships.find(ship)
			player2_attacks += 1
	#check_winning_conditions()
	if player1_attacks == 0:
		player2_turn = true
		Global.allow_ship_interaction = false
	else:
		Global.allow_ship_interaction = true
		player2_turn = false
	round += 1
	#$"../UI/Round".text = "Round : " + str(round)
	########
	#print(p1_round_attacks)
	pass
func check_winning_conditions():
	if len(player1_ships) == 0 :
		print("Player 2 won")
	if len(player2_ships) == 0:
		print("Player 1 won")
		
func check_hit_zone(hit_coords : Vector2, player : int, damage: float, ball_type, ship : Ship):
	#print(damage)
	match player:
		0: # Player 1
			for p1_ship in default_ships_player1:
				match hit_coords:
					p1_ship.top_cell:
						Signals.emit_signal("Enemy_AI_Attacked",ship.id,hit_coords)
						p1_ship.take_damage(damage,0,ball_type,ship)
						print("hit_top")
					p1_ship.mid_cell:
						Signals.emit_signal("Enemy_AI_Attacked",ship.id,hit_coords)
						p1_ship.take_damage(damage,1,ball_type,ship)
						print("hit_mid")
					p1_ship.bot_cell:
						Signals.emit_signal("Enemy_AI_Attacked",ship.id,hit_coords)
						p1_ship.take_damage(damage,2,ball_type,ship)
						print("bot_mid")
		1: # Player 2
			for p2_ship in default_ships_player2:
				#print(damage)
				match hit_coords:
					p2_ship.top_cell:
						p2_ship.take_damage(damage,0,ball_type,ship)
						print("hit_top",p2_ship.health)
					p2_ship.mid_cell:
						p2_ship.take_damage(damage,1,ball_type,ship)
						print("hit_mid",p2_ship.health)
					p2_ship.bot_cell:
						p2_ship.take_damage(damage,2,ball_type,ship)
						print("bot_mid",p2_ship.health)
	pass
func add_ship(player : int, ship : Ship):
	match player:
		0: # Player 1
			player1_ships.append(ship)
			player1_attacks += 1
		1: # Player 2
			player2_ships.append(ship)
			player2_attacks += 1
	#print(len(player1_ships))
	
	#if len(player1_ships) == 3 or len(player2_ships) == 3:
		#print("test")
	#	new_round()
		
		
func attack_button_pressed():
	if p1_round_attacks < player1_attacks:
		attack(0)
	#Signals.emit_signal("player1_attack")
	pass # Replace with function body.


func _on_enemy_area_pressed():
	#camera_animation.play("go_to_enemy_camera")
	Signals.emit_signal("ship_menu_opened")
	pass # Replace with function body.

func prepare_next_round():
	#$"../UI/Attack Button".visible = false
	$"../UI/Next Round".visible = true

func _on_next_round_pressed():
	#$"../UI/Attack Button".visible = true
	$"../UI/Next Round".visible = false
	new_round()
	pass # Replace with function body.

func hit_chance(chance):
	var hit_chance = randi_range(0,100)
	if chance > hit_chance:
		return true
	else:
		return false
		
func attack(current_p : int):
	print(selected_player_ship._name)
	Signals.emit_signal("ship_menu_opened")
	var enemy_ship_part = randi_range(1,3)
	var hit : bool
	var damage_multiplier = false
	match current_p:
		0:
			p1_round_attacks += 1
			if p1_round_attacks < player1_attacks:
				Global.rotate_camera(0)
			else:
				Global.allow_ship_interaction = false
				player2_turn = true
		1:
			p2_round_attacks += 1
			if p2_round_attacks < player2_attacks:
				pass
				#Global.rotate_camera(0)
			player2_turn = true
	
	if current_p == 0:	
		await get_tree().create_timer(.5).timeout
	selected_player_ship.shooting_animation.play("shooting")
	if selected_player_ship.attack_stopped_for == 0 and selected_enemy_ship.can_attack:
		if selected_player_ship.selected_projectile.status_effect != null:
			selected_player_ship.attack_stopped_for = selected_player_ship.selected_projectile.status_effect.stop_action_for
		
		match enemy_ship_part:
			1: # back
				hit = hit_chance(70)
				damage_multiplier = hit_chance(50) #1.5
			2: # mid
				hit = hit_chance(90)
				damage_multiplier = hit_chance(25) #2
			3: # tip
				hit = hit_chance(60)
				damage_multiplier = hit_chance(10)#1.1
		if hit:
			match enemy_ship_part:
				1: # back
					damage_multiplier = 1.5
				2: # mid
					damage_multiplier = 2
				3: # tip
					damage_multiplier = 1.1
			var projectile = selected_player_ship.selected_projectile
			selected_enemy_ship.take_damage(projectile.damage * damage_multiplier, enemy_ship_part-1, projectile, selected_player_ship)
		selected_player_ship.attacked = true
		selected_player_ship = null
	pass




func summon_attack(player_ship, attacked_player : int, attack_coords_array,obj):
	print("attacking")
	for ship in player_ship:
		if ship.attack_stopped_for == 0 and ship.attack_coords in attack_coords_array:
			print(ship.name,ship.attack_coords)
			var loc = ship.attack_coords
			if ship.cannons == 2:
				ship.attack_stopped_for = 2
			if ship.cannons == 3:
				#print("3 cannons")
				ship.attack_stopped_for = 3
			#balls_attack_stop(ship)
			
			#if attacked_player == 0 and ship.id == 0:
			##	loc.x = -91
			#	loc.z = -11
			var i_obj = obj.instantiate()
			get_tree().root.add_child(i_obj)
			i_obj.global_position = loc
			ship.attack_coords = Vector3()
			ship.cannons = 1
			if ship.selected_projectile.status_effect != null:
				ship.attack_stopped_for = ship.selected_projectile.status_effect.stop_action_for
			#var cannon_ball_level = ship.ship_cannon_balls.ball_type(ship.cannon_ball)
			check_hit_zone(Vector2(loc.x,loc.z),attacked_player,ship.selected_projectile.damage, ship.selected_projectile,ship)

func balls_attack_stop(ship):
	match ship.cannon_ball:
			1: # Fire Ball
				ship.attack_stopped_for = 2
			2: # Sleeping Ball
				ship.attack_stopped_for = 2

func _on_start_match_pressed():
	$"../UI/Attack Button".visible = true
	$"../UI/Start Match".visible = false
	match_started = true
	new_round()
	pass # Replace with function body.

func add_currency(type : int , amount : int):
	print("added currency ", amount, " player amount ", player_data.coins)
	match type:
		0:
			player_data.coins += amount
		1:
			player_data.pearls += amount
	ResourceSaver.save(player_data,"res://Data/Player/Player.tres")

func save_player():
	
	for i in player1_ships:
		var scene = PackedScene.new()
		scene.pack(i)
		ResourceSaver.save(scene,"res://Data/Player/Ships/"+i._name.replace("'","").replace(" ","")+".tscn")
		print("saved")
	pass

func load_player():
	var active_ships = player_data.active_ships
	
	for i in active_ships:
		var obj = i.instantiate()
		print(obj._name)
		obj.match_game = self
		get_tree().root.get_node("Game").add_child.call_deferred(obj)
		obj.name = "Ship " + str(randi())
		print(obj.match_game)
	
	'''
	var save_game = FileAccess.open("res://Data/Abilities.json", FileAccess.READ)
	var json_string = save_game.get_line()

		# Creates the helper class to interact with JSON
	var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

		# Get the data from the JSON object
	var node_data = json.get_data()
	var n = 0
	print(node_data[0].keys())

	for i in range(len(node_data)):s
		var data = node_data[i][node_data[i].keys()[0]]
		var new_ship = load("res://Prefabs/Ships/player_ship.tscn").instantiate()
		new_ship._name = node_data[i].keys()[0]
		new_ship.ship_level = int(data.level)
		new_ship.max_health = data.max_health
		new_ship.max_cannons = data.max_cannons
		new_ship.ship_size = data.ship_size
		new_ship.user = 0
		new_ship.name = "Ship " + str(randi())
		get_tree().root.get_node("Game").add_child.call_deferred(new_ship)
		new_ship.global_rotation = Vector3(0,data.rotation,0)
		new_ship.cell_rotation = data.rotation
		new_ship.global_position = Vector3(data.position.x,1,data.position.z)
		print(get_tree().root.get_node("Game").get_node("MATCH GAME"))
	
	while n <= 3:
		n += 1
		for name in names:
			for i in node_data:
				print(i[name])
	'''
