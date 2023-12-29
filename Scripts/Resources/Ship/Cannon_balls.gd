extends Resource
class_name Cannon_Balls_resource
@export_enum("Combat","Utility") var tag = 0
@export var texture : Texture
@export var name : String = ""
@export var level : int = 1
@export var damage : int = 10
@export var coooldown : float = 2;
@export var status_effect : Status_Effect
@export_multiline var description : String = ""
@export var amount : int:
	get:
		return 100
	set(value):
		amount_changed()
		amount = value
#@export_group("")
#@export var Cannon_Ball : bool = true
#@export var Fire_Ball : bool = false
#@export var Sleeping_Gas_Ball : bool = false
var balls = []
func amount_changed():
	print("Value Changed")

func interact():
	if status_effect != null:
		match status_effect.status:
			2:
				Global.m_game.action = "healing"
	else:
		Global.m_game.action = "combat"
	pass

func load_balls():
	#if Cannon_Ball:
	#	balls.append("Cannon Ball")
	#if Fire_Ball:
	#	balls.append("Fire Ball")
	#if Sleeping_Gas_Ball:
	#	balls.append("Sleeping Gas Ball")
	pass
