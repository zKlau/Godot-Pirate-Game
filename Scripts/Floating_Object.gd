extends RigidBody3D

@export var float_force := 1.0
@export var water_drag := 0.05
@export var water_angular_drag := 0.05 #0.5
@export var speed : float = 0.01

@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var water = Global.water


@onready var probes = $ProbeContainer.get_children()

var submerged := false
@onready var hit_points = $"../Hit Points"

@export var ship : bool = false
var parent
# Called when the node enters the scene tree for the first time.
func _ready():
	if ship:
		$"..".ship_model = self
	water = Global.water
	probes = $ProbeContainer.get_children()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func knockback(point):
	apply_impulse(point.global_position,Vector3.UP * .5) #0.5
func _input(event):
	if Input.is_action_pressed("2"):
		print("te")
		#apply_impulse(hit_points.mid.global_position,Vector3.UP * 0.5)
func load_info():
	water = Global.water
	probes = $ProbeContainer.get_children()
	print("teee")
	set_physics_process(true)
func _physics_process(delta):
	#add_constant_force(-Vector3.RIGHT * speed * delta)
	#add_constant_force(Vector3(-1,0,1) * speed)
	submerged = false
	for p in probes:
		var depth = Global.water.get_height(p.global_position) - p.global_position.y 
		if depth > 0:
			submerged = true
			apply_force(Vector3.UP * float_force * gravity * depth, p.global_position - global_position)
func _integrate_forces(state: PhysicsDirectBodyState3D):
	if submerged:
		state.linear_velocity *=  1 - water_drag
		state.angular_velocity *= 1 - water_angular_drag 
