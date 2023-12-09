extends Node
class_name Ship_Combat

@export var enabled : bool = true;
var attack_power : int

func attack(attacker):
	attacker.model.shooting_animation.anim.play("shooting")
	if attacker.right_cast.get_collider() != null:
		if attacker.right_cast.get_collider().name == "Ship_hitBox":
			attacker.right_cast.get_collider().get_parent().get_parent().get_parent().combat.take_damage(attacker._cannons[attacker._selected_cannon_id])
		
		#print("Attacking ", attacker._cannons[attacker._selected_cannon_id].damage)
	pass
	
func take_damage(cannon):
	get_parent().ship._health -= cannon.damage
	print("Damage")
	pass
