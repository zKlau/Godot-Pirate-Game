extends TextureButton

@export var ability : Resource
@onready var parent : Control = $"../../.."
var hover : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	name = ability.name
	tooltip_text = ability.description
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if parent.ship.attacked or !parent.ship.can_attack:
		disable_button()
	else:
		enable_button()
	pass

func set_texture(texture):
	$ability_texture.texture = texture


func _on_pressed():
	parent.ship.selected_projectile = ability
	parent.close_menu()
	#parent.visible = false
	#Signals.emit_signal("ship_menu_closed")
	#print(ability.name, ability.damage)
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
