extends HBoxContainer

@onready var projec_holder : PackedScene = preload("res://Prefabs/User Interface/Buttons/normal_ability_button.tscn")
# Called when the node enters the scene tree for the first time.
@onready var parent : Control = $"../.."
func _ready():
	pass # Replace with function body.

func load_projectiles():
	var projectiles = parent.ship.ship_projectiles

	for i in projectiles:
		var obj = projec_holder.instantiate()
		obj.ability = i
		obj.set_texture(i.texture)
		#obj.text = i.name
		self.add_child(obj)
	pass
