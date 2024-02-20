extends Control
class_name Dialogue


@onready var _name : RichTextLabel = $Name;
@onready var _text : RichTextLabel = $Text;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func display_text(diag,text_speed):
	var sname = diag._name
#	list = diag.diag[0]
	for n in diag.diag:
		n.text = tr(n.text)
		_name.text = sname;
		_text.text = n.text;
		_text.visible_characters = 0;
		for i in range(len(n.text)):
			await get_tree().create_timer(5/text_speed).timeout
			_text.visible_characters += 1;		
		await get_tree().create_timer(2).timeout
	await get_tree().create_timer(1).timeout
	Global.ui.temp_distroy_ui()
		
