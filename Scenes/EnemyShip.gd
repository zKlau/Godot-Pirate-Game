extends CharacterBody3D
class_name EnemyShip

@export var ship : Ship
@export var combat : Ship_Combat
@export var rotation_force : int = 70
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var stop_movement : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()
	pass
