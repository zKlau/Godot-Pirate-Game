extends Node
class_name Ship_Combat

@export var enabled : bool = true;
var attack_power : int
@export var parent : Ship
var time : float = 0
# Fire
var on_fire : bool = false
var fire_duration : float
var fire_damage : int
# Sleep
var on_sleep : bool = false
var sleep_duration : float


func _init():
	if parent == null:
		parent = get_parent()	

func round_place(num,places):
	return (round(num*pow(10,places))/pow(10,places))
	
func attack(attacker):
	if on_sleep == false:
		for i in attacker.right_cast.casts:
			if i.get_collider() != null and attacker.model.shooting_animation.anim.is_playing() == false:
				if i.get_collider().name == "Ship_hitBox":
					i.get_collider().get_parent().get_parent().combat.take_damage(attacker._cannons[attacker._selected_cannon_id])
					print("attack")
		attacker.model.shooting_animation.anim.play("shooting")
	pass
	
func _physics_process(delta):
	if on_fire:
		if Engine.get_process_frames() % Global.ticks == 0 and fire_duration > 0:
			parent._health -= fire_damage
		if fire_duration <= 0:
			parent.model.enable_fire(false)
			on_fire = false
		fire_duration -= delta
	if on_sleep:
		if Engine.get_process_frames() % Global.ticks == 0 and sleep_duration > 0:
			parent.get_parent().stop_movement = true
		if sleep_duration <= 0:
			on_sleep = false
			parent.get_parent().stop_movement = false
		sleep_duration -= delta
	pass

func take_damage(cannon):
	parent._health -= cannon.damage
	#parent.ship.model.knockback()
	if cannon.status_effect != null:
		print(cannon.status_effect.cooldown)
		match (cannon.status_effect.status):
			0:
				on_fire = true
				fire_damage = cannon.status_effect.damage_over_time
				fire_duration = cannon.status_effect.duration
				parent.model.enable_fire(true)
				print("Fire")
			1:
				on_sleep = true
				sleep_duration = cannon.status_effect.duration
				print("Sleep")
			2:
				print("Heal")
	print("Damage")
	pass
