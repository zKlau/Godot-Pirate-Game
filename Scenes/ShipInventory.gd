extends Node
class_name ShipInventory

@export var parent : Ship
@export var food : int = 100
@export var water : int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	#ResourceSaver.save(self,"res://Data/Player/Player.tres")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
