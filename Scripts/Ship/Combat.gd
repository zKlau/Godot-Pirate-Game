extends Node
class_name Ship_Combat

@export var enabled : bool = true;
var attack_power : int

func attack(attacker):
	for i in attacker.right_cast.casts:
		if i.get_collider() != null and attacker.model.shooting_animation.anim.is_playing() == false:
			if i.get_collider().name == "Ship_hitBox":
				i.get_collider().get_parent().get_parent().get_parent().combat.take_damage(attacker._cannons[attacker._selected_cannon_id])
				print("attack")
	attacker.model.shooting_animation.anim.play("shooting")
		#print("Attacking ", attacker._cannons[attacker._selected_cannon_id].damage)
	pass
	
func take_damage(cannon):
	get_parent().ship._health -= cannon.damage
	get_parent().ship.model.knockback()
	print("Damage")
	pass
