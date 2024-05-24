extends Enemy

func set_animation(direction):
	animationPlayer.play("walk")
	sprite.flip_h = (direction.x == 0 && sprite.flip_h) || (direction.x > 0)
