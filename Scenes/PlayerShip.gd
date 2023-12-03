extends Node3D
class_name PlayerShip

@export var _name : String = ""
@export var _level : int = 1
@export var _maxHealth : int = 2500
@export var model : RigidBody3D
@export var _cannons : Array[Resource]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
