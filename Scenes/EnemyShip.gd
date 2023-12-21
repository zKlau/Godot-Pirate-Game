extends CharacterBody3D
class_name EnemyShip

@export var ship : Ship
@export var combat : Ship_Combat
@export var rotation_force : int = 70
@export var speed : float = 10
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var stop_movement : bool = false
var target_direction
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if target_direction != null:
		velocity.x = target_direction.x * speed
		velocity.z = target_direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()
	pass
