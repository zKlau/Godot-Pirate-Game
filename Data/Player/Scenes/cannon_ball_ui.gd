extends Control
class_name Cannonball_component_ui

@onready var icon = $Sprite2D
var _id : int = 0
@onready var level = $Level
var parent
# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent().get_parent()
	pass # Replace with function body.

func set_name_(_name):
	$Name.text = _name
func set_sprite(sprite):
	$Sprite2D.texture = sprite
func set_level(level):
	$Level.text = str(level)
func set_id(id):
	_id = id
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_up_pressed():
	print("res://Data/Player/Vessels/"+parent.ship._name+"/"+parent.ship._cannons[_id].name.replace(" ","")+".tres")
	parent.ship._cannons[_id].level += 1
	ResourceSaver.save(parent.ship._cannons[_id],"res://Data/Player/Vessels/"+parent.ship._name+"/"+parent.ship._cannons[_id].name.replace(" ","")+".tres")
	$Level.text = str(parent.ship._cannons[_id].level)
	pass # Replace with function body.
