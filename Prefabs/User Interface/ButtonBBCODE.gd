extends Button

@onready var rtl_text : String = $RichTextLabel.text
func _ready():
	_set_text("[u]asdf[/u]")

func _set_text(txt):
	$RichTextLabel.text = txt


func _on_mouse_entered():
	$RichTextLabel.text = "[color=]"+"[wave amp=50.0 freq=5.0 connected=1]" + rtl_text + "[/wave]"
	pass # Replace with function body.


func _on_mouse_exited():
	$RichTextLabel.text = rtl_text
	pass # Replace with function body.
