extends Node3D
class_name Ship

@export var _name : String = ""
@export var _level : int = 1
@export var _maxHealth : int = 2500
@export var model : RigidBody3D
@export var _cannons : Array[Resource]
@export var _selected_cannon_id : int = 0
@export var _health : float = _maxHealth

@export var combat : Ship_Combat

var right_cast : Ship_Casts
# Called when the node enters the scene tree for the first time.
func _ready():
	right_cast = model.right_cast
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
