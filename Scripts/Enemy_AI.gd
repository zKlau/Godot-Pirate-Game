@icon("res://Assets/Textures/Icons/processor.svg")
class_name Enemy_AI
extends Node3D


@onready var ship = get_parent()
@export_enum("Normal","Hard") var difficulty = 0
var hit_coords : Vector2
var ship_hit : bool = false
var rand_num : int
var new_a_round : int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("Enemy_AI_Attacked",attack)
	Signals.connect("new_round",new_round)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(ship.attack_stopped_for)
	if ship.on_fire and ship.attack_stopped_for == 0:
		ship.ship_menu.water = true
		ship.attack_stopped_for = 2
		ship.stop_fire()
	pass

	if ship_hit:
		rand_num = randi_range(0,7)
		generate_hit_spot(rand_num,hit_coords)
		pass
		
func new_round():
	new_a_round += 1
		
	if new_a_round == 2:
		ship_hit = false	
func generate_hit_spot(rnd_n,coords):
		match rnd_n:
			0: # Top cell
				ship.attack_coords = Vector3(coords.x,1,coords.y+2)
			1: # Bottom cell
				ship.attack_coords = Vector3(coords.x,1,coords.y-2)
			2: # Left cell
				ship.attack_coords = Vector3(coords.x-2,1,coords.y)
			3: # Right cell
				ship.attack_coords = Vector3(coords.x+2,1,coords.y)
			4: # Top Right cell
				ship.attack_coords = Vector3(coords.x+2,1,coords.y+2)
			5: # Bottom Right cell
				ship.attack_coords = Vector3(coords.x+2,1,coords.y-2)
			6: # Top Left cell
				ship.attack_coords = Vector3(coords.x-2,1,coords.y+2)
			7: # Bottom Left cell
				ship.attack_coords = Vector3(coords.x-2,1,coords.y-2)		
func attack(ship_id ,coords):
	
	print("ship attacker ",ship_id, coords)
	if ship_id == ship.id:
		new_a_round = 0
		if difficulty == 1:
			ship_hit = true
		var rnd_n = randi_range(0,7)
		generate_hit_spot(rnd_n,coords)
		#var random_coords = coords
		#ship.attack_coords = Vector3(coords.x,1,coords.y)
		hit_coords = coords
		print(ship_id," ai attacked ",ship.attack_coords)
	pass
