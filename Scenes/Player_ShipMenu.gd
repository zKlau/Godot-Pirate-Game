extends Control

@onready var _name = $Name
@onready var ship = $".."
@export var cannonball_component : PackedScene
@onready var anim = $UI_Animations
var ship_menu_anim : bool = false
# Called when the node enters the scene tree for the first time.
func render_projectiles():
	for i in ship._cannons:
		var obj = cannonball_component.instantiate()
		obj.set_name_(i.name)
		obj.set_level(i.level)
		obj.set_sprite(i.texture)
		obj.set_id(ship._cannons.find(i))
		$CannonBalls.add_child(obj)
	pass

func _ready():
	render_projectiles()
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ship_menu") and !anim.is_playing():
		if ship_menu_anim:
			anim.play("Ship_menu_out")
			ship_menu_anim = false
		else:
			anim.play("Ship_menu_in")
			ship_menu_anim = true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Stats.text = $Stats.text.replace("{level}",str(ship._level)).replace("{max_health}",str(ship._maxHealth)).replace("{health}",str(ship._health)) 
	#_name.text = ship._name + str(ship._level) + " Level " + str(ship._cannons[0].level)
	pass
