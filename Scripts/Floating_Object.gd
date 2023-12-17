extends RigidBody3D

@export var float_force := 1.0
@export var water_drag := 0.05
@export var water_angular_drag := 0.05 #0.5
@export var speed : float = 0.01

@onready var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var water = Global.water
@export var foam : Node3D
@onready var right_cast : Ship_Casts = $"Right_casts"
@onready var probes = $ProbeContainer.get_children()
@export var fire : Node3D
var submerged := false
@onready var hit_points = $"../Hit Points"
#@onready var ocean = $"../../DeepOcean/WaterMaterialDesigner"
@export var ship : bool = false
var parent
@export var y_rotation_lock : float = 1.5
var shooting_animation
var time = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if ship:
		$"..".ship_model = self
	water = Global.water
	probes = $ProbeContainer.get_children()
	pass # Replace with function body.
	
func enable_foam():
	for e in range(0,foam.get_child_count()):
		foam.get_child(e).visible = true
		foam.get_child(e).emitting = true
func disable_foam():
	for e in range(0,foam.get_child_count()):
		foam.get_child(e).emitting = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func enable_fire(state):
	fire.visible = true
	for i in fire.get_children():
		i.get_child(0).emitting = state

func knockback():
	apply_impulse(global_position,Vector3.UP * 0.01) #0.5

		#apply_impulse(hit_points.mid.global_position,Vector3.UP * 0.5)
func load_info():
	water = Global.water
	probes = $ProbeContainer.get_children()
	print("teee")
	set_physics_process(true)

func average(arr):
	var res = 0
	for i in arr:
		res += i
	return (res/len(arr))
func _physics_process(delta):
	time += delta
	submerged = false
	var arr = []
	for p in probes:
		for i in range(4):
			arr.append(-Global.water.height_waves[i].P_DEG(p.global_position.x,p.global_position.y,p.global_position.z,time).y - p.global_position.y)
		
		#var depth = Global.water.get_height(p.global_position) - p.global_position.y 
		var depth = average(arr) - global_position.y
		if depth > 0:
			submerged = true
			apply_force(Vector3.UP * float_force * gravity * depth, p.global_position - global_position)
func _integrate_forces(state: PhysicsDirectBodyState3D):
	rotation_degrees.y = y_rotation_lock
	if submerged:
		state.linear_velocity *=  1 - water_drag
		state.angular_velocity *= 1 - water_angular_drag 
