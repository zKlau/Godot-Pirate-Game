extends Resource
class_name Player_Data

@export var _name : String = "Joe"
@export var level : int = 0
@export var coins : int = 0
@export var pearls : int = 0

@export_category("Ships")
@export var owned_ships : Resource
@export var active_ships : Array[PackedScene]
