extends Node3D
class_name Ship

@export var _name : String = ""
@export var _level : int = 1
@export var _maxHealth : int = 2500
@export var model : RigidBody3D
@export var _cannons : Array[Resource]
@export var _selected_cannon_id : int = 0
@export var _health : float = _maxHealth

@export var SPEED = 10.0
var max_speed : float = SPEED
@export var acceleration : float = 2
@export var rotation_force : float = 50

@export var combat : Ship_Combat

var right_cast : Ship_Casts
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("save_game",save_game)
	right_cast = model.right_cast
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func save_game():
	print("Saving Ship's Inventory")
	for i in _cannons:
		ResourceSaver.save(i,"res://Data/Player/Vessels/"+_name+"/"+ i.name.replace(" ","") +".tres")
	pass
