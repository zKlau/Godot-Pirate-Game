extends Node3D

var reward : Resource
@export var destroy_particles : PackedScene
var main_
# Called when the node enters the scene tree for the first time.
func _ready():
	if reward != null :
		reward.generate_reward()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Collider.position = Vector3($FloatingObject.position.x,0,$FloatingObject.position.z)
	pass
	
func enable_phisycs():
	$FloatingObject.set_physics_process(false)
	#$FloatingObject.set_process(false)
	$FloatingObject.load_info()
	#$FloatingObject.set_process(true)
func interact():
	print(reward.reward_amount)
	main_.add_currency(0,reward.reward_amount)
	var part = destroy_particles.instantiate()
	get_tree().root.add_child.call_deferred(part)
	part.global_position = $FloatingObject.global_position
	queue_free()
	
