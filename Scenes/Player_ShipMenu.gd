extends Control

@onready var _name = $Name
@onready var ship = $".."
# Called when the node enters the scene tree for the first time.
func _ready():
	_name.text = ship._name + str(ship._level) + str(ship._cannons[0].level)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
