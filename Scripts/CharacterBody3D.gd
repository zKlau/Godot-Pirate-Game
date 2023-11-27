extends CharacterBody3D


@export var SPEED = 10.0
const JUMP_VELOCITY = 4.5
@export var ship : RigidBody3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
#@onready var ocean = $"../WaterPoint"
func _ready():
		Global.player = self
func _physics_process(delta):
	RenderingServer.global_shader_parameter_set("ocean_pos", self.position);
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
	#ocean.position = lerp(ocean.position,self.position,delta*0.1)
	if input_dir.y == 0 and input_dir.x == 0:
		ship.disable_foam()
		#ocean.position.x = self.position.x
		#ocean.position.z = self.position.z
	if input_dir.y == -1:
		ship.enable_foam()
		#ocean.position.x = lerp(ocean.position.x,self.position.x,delta*0.1)
		#ocean.position.z = lerp(ocean.position.z,self.position.z,delta*0.1)
		
	if input_dir.y != 0:
		rotate_y(-input_dir.x/50)
		#ocean.rotation.y = rotation.y
	elif input_dir.y == 0:
		#ocean.rotation.y = rotation.y
		#print("rotating")
		rotate_y(-input_dir.x/(50*2))
	if input_dir.y > 0:
		input_dir.y = 0
	var direction = (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	#if input_dir.x !=0:
		#rotate_y(0.01)
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
