extends TextureButton

@export_multiline var description : String
# Called when the node enters the scene tree for the first time.
func _ready():
	$Tooltip.set_text(description)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
