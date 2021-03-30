extends RigidBody2D

const CAST_VELOCITY = Vector2(400,0)
var velocity = Vector2.ZERO
export var life_time = 10
export var arrow_damage = 10
var angle = null

func _ready():
	_launch_arrow()

func _launch_arrow():
	apply_impulse(Vector2(), Vector2(CAST_VELOCITY).rotated(rotation))
	angle = Vector2(CAST_VELOCITY).rotated(rotation)
	
func _self_destruct():
	yield(get_tree().create_timer(life_time), "timeout")
	queue_free()
	
func _on_Arrow_body_entered(body):
	if body.is_in_group("Soft"):
		queue_free()
		body.OnHit(arrow_damage, angle)
