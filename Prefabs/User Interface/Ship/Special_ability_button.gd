extends TextureButton

@export_multiline var description : String
@onready var parent = $"../../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	$Tooltip.set_text(description)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if parent.ship.attacked or !parent.ship.can_attack:
		disable_button()
	else:
		enable_button()
		

func disable_button():
	$lock.visible = true
	disabled = true
func enable_button():
	$lock.visible = false
	disabled = false

	pass
