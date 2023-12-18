extends Node
class_name Ship_Battle_AI

@export var target : PlayerBody
@export var aggressive_range : float = 100
@export var parent : EnemyShip
func _init():
	if parent == null:
		parent = get_parent()
	pass
func _physics_process(delta):
	if !parent.stop_movement:
		if parent.global_position.distance_to(target.global_position) <= aggressive_range:
			if parent.ship._health > parent.ship._health *0.10:
				for i in parent.ship.model.right_cast.casts:
					if i.get_collider() != null:
						if i.get_collider().get_parent()._id == 0:
							parent.combat.attack(parent.ship)
							print("attacking")
				
				
				#parent.combat.attack(parent.ship)
			#var direction = (target.global_position - parent.global_position).normalized()
			#var angle = rad_to_deg(acos(direction.dot(parent.transform.basis.z)))
			#print(angle)
			
			#parent.rotate_y(-1/parent.rotation_force)
			pass
		
