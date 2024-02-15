extends Control

@onready var _name : RichTextLabel = $Name;
@onready var _text : RichTextLabel = $Text;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func display_text(diag,sname):
	_name.text = sname;
	_text.text = diag;
	_text.visible_characters = 0;
	
	for i in range(len(diag)):
		await get_tree().create_timer(0.05).timeout
		_text.visible_characters += 2;		
		
