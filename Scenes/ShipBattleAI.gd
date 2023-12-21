extends Node
class_name Ship_Battle_AI

@export var target : PlayerBody
@export var aggressive_range : float = 100
@export var parent : Ship
@export var body : EnemyShip
func _init():
	if parent == null:
		parent = get_parent()
	pass
func _physics_process(delta):
	if !parent.get_parent().stop_movement:
		if parent.global_position.distance_to(target.global_position) <= aggressive_range:
			if parent._health > parent._health *0.10:
				## Detecting if the target is in range and if it is shoots.
				for i in parent.model.right_cast.casts:
					if i.get_collider() != null:
						if i.get_collider().get_parent()._id == 0:
							parent.combat.attack(parent)
							print("attacking")
				## Follow the target 
					var target_position = target.global_transform.origin
					var direction_to_target = (target_position - body.global_transform.origin).normalized() # We normalize the vector because we only care about the direction
					body.target_direction = direction_to_target
					#move_and_slide(direction_to_target * body.speed) # We multiply the direction by the speed
				#parent.combat.attack(parent.ship)
			#var direction = (target.global_position - parent.global_position).normalized()
			#var angle = rad_to_deg(acos(direction.dot(parent.transform.basis.z)))
			#print(angle)
			
			#parent.rotate_y(-1/parent.rotation_force)
			pass
		
