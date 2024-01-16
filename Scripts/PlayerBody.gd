extends CharacterBody3D
class_name PlayerBody


const JUMP_VELOCITY = 4.5
@export var ship : Ship

@export var player_data : Player_Data
@export var combat : Ship_Combat
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var player_at_sea : bool = true
var stop_movement : bool = false;
#@onready var ocean = $"../WaterPoint"
func _ready():
	Signals.connect("save_game",save_player_data)
	Global.player = self

func _input(event):
	if combat != null:
		if combat.enabled:
			if event.is_action_pressed("attack"):
				combat.attack(ship)
				
func _physics_process(delta):
	RenderingServer.global_shader_parameter_set("ocean_pos", self.position);
	
	if player_at_sea:
		if Engine.get_process_frames() % Global.ticks == 0:
			#print(player_data.inventory.food)
			player_data.inventory.food -= 0.5
			player_data.inventory.water -= 1 
			
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if !stop_movement:
		# As good practice, you should replace UI actions with custom gameplay actions.
		var input_dir = Input.get_vector("Left", "Right", "Forward", "Back")
		#ocean.position = lerp(ocean.position,self.position,delta*0.1)
		if input_dir.y == 0 and input_dir.x == 0:
			ship.model.disable_foam()
			pass
			#ocean.position.x = self.position.x
			#ocean.position.z = self.position.z
		if input_dir.y == -1:
			ship.model.enable_foam()
			#ocean.position.x = lerp(ocean.position.x,self.position.x,delta*0.1)
			#ocean.position.z = lerp(ocean.position.z,self.position.z,delta*0.1)
		### The ship is moving ###
		if input_dir.y != 0:
			rotate_y(-input_dir.x/ship.rotation_force)
			#print(-input_dir.x/ship.rotation_force, " rotation")
			#ocean.rotation.y = rotation.y
		### The ship stops moving ###
		elif input_dir.y == 0:
			ship.SPEED = 1
			#ocean.rotation.y = rotation.y
			#print("rotating")
			rotate_y(-input_dir.x/(ship.rotation_force*2))
		if input_dir.y > 0:
			input_dir.y = 0
		var direction = (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
		
		if ship.SPEED < ship.max_speed:
			ship.SPEED += delta * ship.acceleration
		#if input_dir.x !=0:
			#rotate_y(0.01)
		
		if direction:
			velocity.x = direction.x * ship.SPEED
			velocity.z = direction.z * ship.SPEED
		else:
			'''
			if velocity.x >= 0:
				velocity.x -= delta
				
			if velocity.z >= 0:
				velocity.z -= delta
				
			if velocity.x < 0:
				velocity.x = 0
			if velocity.z < 0:
				velocity.z = 0
				'''
				
			velocity = lerp(velocity,Vector3(0,0,0),0.03)
			#velocity.x = move_toward(velocity.x, 0, ship.SPEED)
			#velocity.z = move_toward(velocity.z, 0, ship.SPEED)
		
		move_and_slide()
	
func save_player_data():
	ResourceSaver.save(player_data,"res://Data/Player/Player.tres")
	ResourceSaver.save(player_data.inventory,"res://Data/Player/Inventory.tres")
	pass
