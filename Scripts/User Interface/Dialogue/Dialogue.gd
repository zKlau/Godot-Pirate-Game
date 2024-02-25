extends Control
class_name Dialogue


@onready var _name : RichTextLabel = $Name;
@onready var _text : RichTextLabel = $Text;
@onready var _option : PackedScene = preload("res://Prefabs/User Interface/Dialogue/option_item.tscn")
var _option_continue : bool = false
var _options_objs : Array[Control]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_option(text):
	var obj = _option.instantiate()
	$Options_container.add_child(obj)
	obj.set_text(text);
	_options_objs.append(obj)
	
func button_press():
	_option_continue = false;
	
func destroy_option():
	for x in _options_objs:
		x.queue_free()
	_options_objs.clear()
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
		
		if len(n.option) > 0:
			for x in n.option:
				show_option(x)
			_option_continue = true;
			
			while _option_continue:
				await get_tree().create_timer(0.1).timeout
				pass
			destroy_option()
		else:
			await get_tree().create_timer(2).timeout
	await get_tree().create_timer(1).timeout
	Global.ui.temp_distroy_ui()
		
