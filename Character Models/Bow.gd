extends Node2D

const ARROW_PROJECTILE = preload("res://Equipment/Arrow.tscn")

var rot_times = 0
var rot_360 = 0
var arrow_item = null
var can_shoot = false

export var rotation_left = -90
export var rotation_right = 90

onready var attack_cooldown = $AttackTimer.wait_time
onready var arrow_item_position = $Sprite/arrowPosition

func _spawn_arrow():
	if arrow_item == null and can_shoot == true:
		arrow_item = ARROW_PROJECTILE.instance()
		arrow_item.rotation = get_angle_to(get_global_mouse_position())
		var temp = global_transform
		var scene = get_tree().current_scene
		remove_child(self)
		scene.add_child(self)
		arrow_item_position.add_child(arrow_item)
		arrow_item = null
		
func _physics_process(_delta):
	look_at(get_global_mouse_position())
	
	#distill rotation degrees into 360 degrees
	rot_times = int(rotation_degrees / 360)
	rot_360 = rotation_degrees - (rot_times * 360)
	
	#point rotation 0 point up
	if rot_360 > 0:
		rot_360 = rot_360 - 90
	else:
		rot_360 = rot_360 + 270

	#turn from full 360 negative or positive to 180 negative or positive from 0 point
	if rot_360 <= -180:
		rot_360 = 360 - (rot_360 * -1)
	elif rot_360 > 180 && rot_360 < 360:
		rot_360 = (360 - rot_360) * -1
	
	#set layer z-index based on rotation
	if rot_360 <= rotation_left:
		z_index = 0
	elif rot_360 >= rotation_right:
		z_index = 0
	else:
		z_index = 1


	if Input.is_action_just_pressed("primary_attack"):
		can_shoot = true
		_spawn_arrow()
