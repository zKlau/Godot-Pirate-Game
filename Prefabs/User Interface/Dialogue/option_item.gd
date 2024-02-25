extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_text(tex):
	$Text.text = tex
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_option_button_pressed():
	get_parent().get_parent().button_press()
	pass # Replace with function body.
