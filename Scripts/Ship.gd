@icon("res://Assets/Textures/spyglass.png")
class_name Ship
extends Node3D
@export var _name : String
@export var id : int
@export_range(1,100) var ship_level : int = 1
@export_enum("Player 1","Player 2") var user : int = 0
@export_enum("1","2","3") var ship_size : int
@export_enum("1","2","3") var cannons = 0
var max_cannons : int = 3 
@export_enum("0","45","90","135","180","-135","-45","-90") var ship_rotation : int
@export var health : int = 100
var max_health : int = 100
@onready var cell_location : Vector2 = Vector2(global_position.x,global_position.z)
var cell_rotation = rotation.y
var top_cell : Vector2
var mid_cell : Vector2
var bot_cell : Vector2
var over_water_height : int = 1
var cannon_ball : int = 0
var attack_coords : Vector3
var can_attack : bool = true
var attack_stopped_for : int = 0
var attacked : bool = false
var on_fire : bool = false
var stop_fire_r : bool = false
var sleep : bool = false

var ship_model

@onready var ship_menu : Control = $"Ship_Menu"

var selected = false
@onready var destroyed = $"Destroyed_Fire"
@export_group("Cannon Balls")
@onready var shooting_animation = $Ship_Shooting_Animation/Anim
#@export var cannon_ball_resource : Resource = load("res://Scripts/Resources/Ship/Cannon_balls.gd")
var balls = []

@export var ship_projectiles : Array[Resource]


#@export var cballs : Array[Resource]
var selected_projectile : Resource

var hover : bool = false
@onready var ship_fire = $"Part_Fire"
@onready var match_game
var hit_particles = preload("res://Prefabs/Particles/hit_particles.tscn")
@onready var hit_points = $"Hit Points"
# Called when the node enters the scene tree for the first time.
func _ready():
	#rotation.y = cell_rotation
	
	prepare_cannons()
	#max_health = health
	cannons += 1
	#ship_menu.pre_load(max_cannons,cannons)
	Signals.connect("new_round",new_round)
	#print(cell_location,name)
	#global_position = Vector3(cell_location.x,over_water_height,cell_location.y)
	mid_cell = Vector2(global_position.x,global_position.z)
	
	match ship_rotation:
		0: # 0
			top_cell = Vector2(cell_location.x,cell_location.y-2)
			bot_cell = Vector2(cell_location.x,cell_location.y+2)
		1: # 45
			top_cell = Vector2(cell_location.x-2,cell_location.y-2)
			bot_cell = Vector2(cell_location.x+2,cell_location.y+2)
		2: # 90
			top_cell = Vector2(cell_location.x-2,cell_location.y)
			bot_cell = Vector2(cell_location.x+2,cell_location.y)
		3: # 135
			top_cell = Vector2(cell_location.x-2,cell_location.y+2)
			bot_cell = Vector2(cell_location.x+2,cell_location.y-2)
		4: # 180
			top_cell = Vector2(cell_location.x,cell_location.y+2)
			bot_cell = Vector2(cell_location.x,cell_location.y-2)
		5: # -135
			top_cell = Vector2(cell_location.x+2,cell_location.y+2)
			bot_cell = Vector2(cell_location.x-2,cell_location.y-2)
		6: # -45
			top_cell = Vector2(cell_location.x+2,cell_location.y-2)
			bot_cell = Vector2(cell_location.x-2,cell_location.y+2)
		7: # -90
			top_cell = Vector2(cell_location.x+2,cell_location.y)
			bot_cell = Vector2(cell_location.x-2,cell_location.y)
		
	if match_game == null:
		match_game = %"MATCH GAME"
		print("null")
	#match_game = %"MATCH GAME"
	selected_projectile = ship_projectiles[0]
	#print(top_cell,mid_cell,bot_cell,name)
	match_game.add_default_ships(user,self)
	if health > 0:
		match_game.add_ship(user,self)
	pass # Replace with function body.

func prepare_cannons():
	for i in ship_projectiles:
		print(i.name)
	pass

func interact():
	if Global.allow_ship_interaction:
		print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD")
		Signals.emit_signal("ship_menu_opened")
		ship_menu.update_info()
		#if user == 0:
		ship_menu.visible = true
		if user == 0 and attacked:
			match_game.selected_player_ship  = null
		if user == 0 and attacked == false:
			match_game.selected_player_ship = self
			print("select")
		else:
			print("enemy ship")
			match_game.selected_enemy_ship = self
		
			
func _input(event):
	if hover:
		print("hobering")
		if event is InputEventMouseButton and event.pressed:
			print("pressed")
			
			#interact()
func update_attack_stop():
	if attack_stopped_for > 0:
		attack_stopped_for -= 1


func new_round():
	attacked = false
	update_attack_stop()
	if health > 0:
		#print(_name)
		if ship_menu.water:
			ship_menu.water = false
			on_fire = false
			attack_stopped_for = 2
			print("stop fire")
		if on_fire:
			print("on fire")
			health -= health * 0.1
		if sleep:
			attack_stopped_for = 2
			sleep = false
		#attack_coords = Vector3()
			#print(can_attack,"remove round")
		if attack_stopped_for == 0:
			can_attack == true
		else:
			can_attack = false
		#print(id," ",attack_stopped_for)
		if can_attack:
			match_game.add_ship(user,self)
		pass
	
	pass

func stop_fire():
	ship_menu.water = true
func spawn_particle(part):
	var hit_part_obj = hit_particles.instantiate()
	get_tree().root.add_child.call_deferred(hit_part_obj)
	match part:
		0:
			hit_part_obj.global_position = hit_points.top.global_position
		1:
			hit_part_obj.global_position = hit_points.mid.global_position
		2:
			hit_part_obj.global_position = hit_points.bot.global_position
	pass
func take_damage(damage : float, ship_part : int, projectile, attacker):
	if projectile.status_effect != null:
		print("status effect")
	#print(projectile.status," projectile")
		projectile.status_effect.apply_status(self,attacker)
	#match ball_type:
	#	1:
	#		on_fire = true
	#	2:
	#		sleep = true
	print("damage",damage)
	match ship_part:
		0:
			health -= damage
			ship_model.knockback(hit_points.bot)
			spawn_particle(0)
			if projectile.status_effect != null:
				if projectile.status_effect.status == 0:
					ship_fire.top.visible = true
		1:
			health -= damage #* 1.5
			ship_model.knockback(hit_points.mid)
			spawn_particle(1)
			if projectile.status_effect != null:
				if projectile.status_effect.status == 0:
					ship_fire.mid.visible = true
		2:
			health -= damage
			ship_model.knockback(hit_points.top)
			spawn_particle(2)
			if projectile.status_effect != null:
				if projectile.status_effect.status == 0:
					ship_fire.bot.visible = true	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health <= 0:
		can_attack = false
		destroyed.visible = true
	if attack_stopped_for == 0 and health > 0:
		can_attack = true
		
	if on_fire == false:
		ship_fire.bot.visible = false
		ship_fire.mid.visible = false
		ship_fire.top.visible = false	
	pass
