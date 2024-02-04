extends Control

@export var _name : String

@export var shop_items : Array[Shop_Item]
@export var item_interface : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("save_game",save_game)
	
	for i in shop_items:
		var obj = item_interface.instantiate()
		obj._item = i;
		$Shop.add_child(obj)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func save_game():
	for i in shop_items:
		print(i._stock," res://Data/Islands/Shops/"+_name.replace(" ","")+"/"+ i._name.replace(" ","") +".tscn")
		ResourceSaver.save(i,"res://Data/Islands/Shops/"+ _name.replace(" ","") +"/"+i._name.replace(" ","") +".tres")
		
	pass