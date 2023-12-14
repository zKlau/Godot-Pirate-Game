extends Node
class_name Ship_Combat

@export var enabled : bool = true;
var attack_power : int
@export var parent : CharacterBody3D
var time : float = 0
# Fire
var on_fire : bool = false
var fire_duration : float
var fire_damage : int
# Sleep
var sleep : int = 0
var slee_duration : float


func _init():
	if parent == null:
		parent = get_parent()	

func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))
	
func attack(attacker):
	for i in attacker.right_cast.casts:
		if i.get_collider() != null and attacker.model.shooting_animation.anim.is_playing() == false:
			if i.get_collider().name == "Ship_hitBox":
				i.get_collider().get_parent().get_parent().get_parent().combat.take_damage(attacker._cannons[attacker._selected_cannon_id])
				print("attack")
	attacker.model.shooting_animation.anim.play("shooting")
	pass
	
func _process(delta):
	time += delta;
	if on_fire:
		if Engine.get_process_frames() % 10 == 0 and fire_duration > 0:
			#print("Burning")
			parent.ship._health -= fire_damage
		if fire_duration <= 0:
			on_fire = false
		fire_duration -= delta
		
	pass
func take_damage(cannon):
	parent.ship._health -= cannon.damage
	#parent.ship.model.knockback()
	if cannon.status_effect != null:
		print(cannon.status_effect.cooldown)
		match (cannon.status_effect.status):
			0:
				on_fire = true
				fire_damage = cannon.status_effect.damage_over_time
				fire_duration = cannon.status_effect.duration
				print("Fire")
			1:
				print("Sleep")
			2:
				print("Heal")
	print("Damage")
	pass
