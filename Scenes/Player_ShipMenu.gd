extends Control

@onready var _name = $Name
#@onready var ship = $".."
@export var cannonball_component : PackedScene
@onready var anim = $UI_Animations
var ship_menu_anim : bool = false
# Called when the node enters the scene tree for the first time.
func render_projectiles():
	for i in Global.player.ship._cannons:
		var obj = cannonball_component.instantiate()
		obj.set_name_(i.name)
		obj.set_level(i.level)
		obj.set_sprite(i.texture)
		obj.set_id(Global.player.ship._cannons.find(i))
		$CannonBalls.add_child(obj)
	pass

func _ready():
	#render_projectiles()
	pass # Replace with function body.

func menu():
	if ship_menu_anim:
		Global.ui.temp.remove_child(self)
		Global.player.ship.add_child(self)
		anim.play("Ship_menu_out")
		ship_menu_anim = false
	else:
		Global.player.ship.remove_child(self)
		Global.ui.temp.add_child(self)
		anim.play("Ship_menu_in")
		#owner = Global.player.ship
		
		
		
		ship_menu_anim = true
			
func _input(event):
	if event.is_action_pressed("ship_menu") and !anim.is_playing():
		menu()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Stats.text = $Stats.text.replace("{level}",str(Global.player.ship._level)).replace("{max_health}",str(Global.player.ship._maxHealth)).replace("{health}",str(Global.player.ship._health)) 
	#_name.text = ship._name + str(ship._level) + " Level " + str(ship._cannons[0].level)
	pass


func _on_close_button_pressed():
	menu()
	pass # Replace with function body.
