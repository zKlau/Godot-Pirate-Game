extends Button

@export var hover_text_color : Color
@export var default_text_color : Color
@onready var rtl_text : String = $RichTextLabel.text
func _ready():
	rtl_text = tr($RichTextLabel.text)
	pass

func _set_text(txt):
	$RichTextLabel.text = txt

func _process(delta):
	#print(Color(text_color).to_html(true))
	pass
	
func _on_mouse_entered():
	var color = str(Color(hover_text_color).to_html(true))
	$RichTextLabel.text = "[color="+color+"][wave amp=50.0 freq=5.0 connected=1]" + rtl_text + "[/wave][/color]"
	pass # Replace with function body.


func _on_mouse_exited():
	var color = str(Color(default_text_color).to_html(true))
	$RichTextLabel.text = "[center][color="+color+"]" + rtl_text + "[/color]"
	pass # Replace with function body.

