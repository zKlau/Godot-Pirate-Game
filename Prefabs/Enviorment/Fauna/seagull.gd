extends Node3D

@onready var anim = $AnimationPlayer2
@export_range(20,100) var speed = 20;
# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randi_range(15,35)
	anim.speed_scale = randf_range(0.5,2)
	anim.play("Flying")
	#anim.play("Left_WingAction")
	#anim.play("Right_WingAction")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	translate(Vector3.FORWARD * -speed * delta)
	pass
