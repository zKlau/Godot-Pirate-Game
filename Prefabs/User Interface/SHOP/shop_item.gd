extends Control

@export var _item : Shop_Item
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$Price.text = str(_item._price);
	$Name.text = _item._name;
	$Description.text = _item._description;
	$Icon.texture = _item._icon;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_buy_button_pressed():
	if _item._stock >= _item._amount:
		if _item._type == 0:
			var i : int = 0;
			for x in Global.player.ship._cannons:
				if x.name == _item._name:
					Global.player.ship._cannons[i].amount += _item._amount;
					_item._stock -= _item._amount;
					print(_item._stock)
					Global.player.player_data.coins -= _item._price;
					return
				i += 1;
	pass # Replace with function body.
