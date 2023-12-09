extends Node
class_name Ship_Combat

@export var enabled : bool = true;
var attack_power : int

func attack(attacker):
	if attacker.right_cast.get_collider() != null:
		attacker.right_cast.get_collider().get_parent().get_parent().get_parent().combat.take_damage(attacker._cannons[attacker._selected_cannon_id])
		print("Attacking ", attacker._cannons[attacker._selected_cannon_id].damage)
	pass
	
func take_damage(cannon):
	print("Damage")
	pass
