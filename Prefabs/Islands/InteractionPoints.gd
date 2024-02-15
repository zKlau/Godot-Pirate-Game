extends Node3D

@export var parent : Port

var shop : bool = false;
@export var shop_text : Node3D;

var tavern :bool = false;
@export var tavern_text : Node3D;

var dockyard : bool = false;
@export var dockyard_text : Node3D;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shop:
		if Input.is_action_just_pressed("Left_Click"):
			if !parent.opened:
				parent.show_ui_shop();
			pass
		shop_text.visible = true;
	else:
		shop_text.visible = false;
		
	if tavern:
		if Input.is_action_just_pressed("Left_Click"):
			if !parent.opened:
				parent.show_ui_tavern();
			pass
		tavern_text.visible = true;
	else:
		tavern_text.visible = false;
		
	if dockyard:
		dockyard_text.visible = true;
	else:
		dockyard_text.visible = false;
	pass


func _on_shop_mouse_entered():
	shop = true
	pass # Replace with function body.


func _on_tavern_mouse_entered():
	tavern = true
	pass # Replace with function body.


func _on_dockyard_mouse_entered():
	dockyard = true
	pass # Replace with function body.


func _on_shop_mouse_exited():
	shop = false
	pass # Replace with function body.


func _on_tavern_mouse_exited():
	tavern = false
	pass # Replace with function body.


func _on_dockyard_mouse_exited():
	dockyard = false
	pass # Replace with function body.
