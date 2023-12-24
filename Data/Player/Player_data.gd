extends Resource
class_name Player_Data

@export var _name : String = "Joe"
@export var level : int = 1
@export var experience : int = 0
@export var coins : int = 0
@export var pearls : int = 0
var experience_to_level : int = 4000
@export_category("Ships")
@export var owned_ships : Resource
@export var active_ships : Array[PackedScene]
@export var inventory : ShipInventoryResource

func add_experience(exp):
	experience += exp
	while experience >= experience_to_level:
		experience -= experience_to_level
		level += 1
		experience_to_level = experience_to_level * 1.45
