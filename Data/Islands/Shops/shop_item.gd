extends Resource
class_name Shop_Item

@export var _name : String
@export var _icon : Texture2D
@export_multiline var _description : String
@export var _price : int
@export var _amount : int
@export var _stock : int
@export_enum("Ammo","Provisions") var _type : int;
@export_enum("Coins","Pearls") var _method : int
