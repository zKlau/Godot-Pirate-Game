extends Node3D

@onready var anim =  $AnimationPlayer
@export_range(0,100) var speed = 20;
var jump_anim_time : float = randf_range(2,5)
var time : float
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("swimming")
	speed = randi_range(15,35)
	pass # Replace with function body.

func dictate_animation():
	var dic_anim = randi_range(1,10)
	if dic_anim >= 5:
		anim.play("swimming")
		print("change animation")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	time += delta
	if time >= jump_anim_time:
		anim.play("Jumping")
		time = 0;
		jump_anim_time = randf_range(2,5)
		
	translate(Vector3.FORWARD * speed * delta)
	pass

