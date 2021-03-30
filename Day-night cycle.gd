extends CanvasModulate

func _ready():
	var start_position_seconds = 5.0
	var animation = $AnimationPlayer
	animation.seek(start_position_seconds, true)
