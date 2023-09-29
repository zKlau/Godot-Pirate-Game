extends Resource
class_name Random_object_data_currency

@export var _name : String = ""
@export_enum("Coins","Pearls") var reward_type : int
@export var max_amount : int = 0
@export var min_amount : int = 0
var reward_amount : int = randi_range(min_amount,max_amount)
@export var chance : int = 0

func generate_reward():
	reward_amount = randi_range(min_amount,max_amount)
	print(reward_amount,_name)
