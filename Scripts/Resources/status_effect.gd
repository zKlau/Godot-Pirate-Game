extends Resource
class_name Status_Effect

@export_enum("Fire","Sleep") var status

@export var hit_stop_action : int = 0
@export var stop_action_for : int = 0



func apply_status(attacked_ship,attacker_ship):
	attacker_ship.attack_stopped_for = stop_action_for
	attacked_ship.attack_stopped_for = hit_stop_action
	match status:
		0:
			attacked_ship.on_fire = true
		1:
			attacked_ship.sleep = true
			
