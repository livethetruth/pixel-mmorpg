extends KinematicBody2D

const ACCELERATION = 1500
const MAX_SPEED = 138
const FRICTION = 1250

var velocity = Vector2.ZERO
var can_attack = true
export (float) var attack_cooldown = 1

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


func _ready():
	animationTree.active = true
	
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	#Reduce Y axis height to match tile size ratio
	velocity.y = velocity.y * .9
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("dodge"):
		pass

	if Input.is_action_just_pressed("menu"):
		if Globals.menu_shown == false:
			get_node("../../UI/GameMenu").show()
			Globals.menu_shown = true
		else:
			get_node("../../UI/GameMenu").hide()
			Globals.menu_shown = false

