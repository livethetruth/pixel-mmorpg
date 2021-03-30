extends StaticBody2D

onready var arrow_item_position = $Sprite/arrowHitPoint

func _ready():
	pass

func OnHit(_damage, angle):
	var my_texture = load("res://Equipment/Arrow.png")
	var sprite = Sprite.new( )
	sprite.look_at(angle)
	sprite.set_offset(Vector2(-9, 2))
	sprite.set_texture(my_texture)
	arrow_item_position.add_child(sprite)
