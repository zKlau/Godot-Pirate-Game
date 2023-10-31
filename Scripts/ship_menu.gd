extends Control

var cannons : int = 1

var water : bool = false
var hover : bool = false

@onready var ship = get_parent()
@export var texture_normal : Texture
@export var texture_enemy : Texture
@onready var background = $ColorRect
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("ship_menu_opened",close_menu)
	$"Ship Name".text = ship._name
	update_info()
	
	
	if ship.user == 1:
		$Player.visible = false
		$Enemy.visible = true
		$menu_texture.texture = texture_enemy
	
	for i in $"Player/Normal Projectiles".get_children():
		i.pressed.connect(ability_button)
		print(i)
	$"Player/Normal Projectiles".load_projectiles()
	pass # Replace with function body.
func ability_button():
	print(get_parent().name)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		if Global.m_game.action == "healing" and ship.health > 0:
			$Player/Heal_Button.visible = true
		else:
			$Player/Heal_Button.visible = false
		$Player/Health/Health_percentage.text = str($Player/Health.value) + "%"
		$Enemy/Health/Health_percentage.text =  str($Enemy/Health.value) + "%"
		if ship.user == 0:
			$Player/Health.value = ship.max_health - ship.health
		else:
			$Enemy/Health.value = ship.max_health - ship.health
	if get_viewport().get_mouse_position()[1] < background.global_position.y:
		Global.cursor_click_ship = true
	else:
		Global.cursor_click_ship = false
	#print(cannon_number_options.selected+1)
	pass

func update_info():
	pass
	#cannon_number_options.selected = ship.cannons-1
	
func close_menu():
	Global.mouse_action = true
	visible = false
	Signals.emit_signal("ship_menu_closed")
	
func _on_close_menu_button_pressed():
	close_menu()
	pass # Replace with function body.


func _on_cannon_buttons_item_selected(index):
	cannons = index+1
	ship.cannons = cannons
	print(ship.cannons)
	pass # Replace with function body.


func _on_water_box_pressed():
	ship.attack_stopped_for = 1
	ship.stop_fire()
	water = true
	
	Global.m_game.selected_player_ship.attacked = true
	Global.m_game.p1_round_attacks += 1
	Global.m_game.selected_player_ship = null

	if Global.m_game.p1_round_attacks < Global.m_game.player1_attacks:
		pass
		#Global.rotate_camera(0)
	else:
		Global.allow_ship_interaction = false
		Global.m_game.player2_turn = true
	#Global.allow_ship_interaction = false
	#Global.m_game.player2_turn = true
	pass # Replace with function body.


func _on_cannon_ball_buttons_item_selected(index):
	#ship.on_fire = true
	ship.selected_projectile = ship.ship_projectiles[index]
	#print(ship.selected_projectile)
	#ship.cannon_ball = CannonBalls.get_ball_id(ship.balls[index])
	#print(CannonBalls.get_ball_id(ship.balls[index]),ship.balls[index])
	pass # Replace with function body.


func _on_mouse_entered():
	print("enter")
	pass # Replace with function body.


func _on_mouse_exited():
	print("exit")
	pass # Replace with function body.


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("I've been clicked D:")
	pass # Replace with function body.


func _on_focus_entered():
	print("focus")
	pass # Replace with function body.


func _on_color_rect_mouse_entered():
	hover = true
	pass # Replace with function body.


func _on_color_rect_mouse_exited():
	hover = false
	pass # Replace with function body.


func _on_menu_collision_mouse_entered():
	print("mouse over")
	Global.cursor.ship_menu_over = true
	pass # Replace with function body.


func _on_menu_collision_mouse_exited():
	print("mouse left")
	Global.cursor.ship_menu_over = false
	pass # Replace with function body.


func _on_attack_button_pressed():
	Signals.emit_signal("attack_button")
	pass # Replace with function body.


func _on_heal_button_pressed():
	Global.m_game.ship_utility_interaction(0,ship)
	pass # Replace with function body.
