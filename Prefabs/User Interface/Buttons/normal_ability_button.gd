extends TextureButton

@export var ability : Resource
@onready var parent : Control = $"../../.."
var hover : bool = false
@onready var tooltip = $Tooltip
# Called when the node enters the scene tree for the first time.
func _ready():
	name = ability.name
	format_tooltip()
	pass # Replace with function body.

func format_tooltip():
	ability.description = ability.description.replace("{damage}",str(ability.damage))
	ability.description = ability.description.replace("{level}",str(ability.level))
	tooltip.set_text(ability.description)
	#tooltip_text = ability.description
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if parent.ship.attacked or !parent.ship.can_attack or Global.m_game.action == "healing":
		disable_button()
	else:
		enable_button()
	pass

func set_texture(texture):
	$ability_texture.texture = texture


func _on_pressed():
	parent.ship.selected_projectile = ability
	ability.interact()
	parent.close_menu()
	#if Global.m_game.selected_player_ship == null:
		#if Global.m_game.selected_player_ship.selected_projectile.tag == 0:
			
	#parent.visible = false
	#Signals.emit_signal("ship_menu_closed")
	#print(ability.name, ability.damage)
	if ability.tag == 0:
		Global.rotate_camera(90)
	
	#Global.camera.quaternion = Vector3(0,1,0)
	pass # Replace with function body.

func disable_button():
	$lock.visible = true
	disabled = true
func enable_button():
	$lock.visible = false
	disabled = false

func _on_mouse_entered():
	parent.hover = true
	hover = true
	pass # Replace with function body.


func _on_mouse_exited():
	hover = false
	pass # Replace with function body.
