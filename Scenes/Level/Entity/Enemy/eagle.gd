extends Enemy

func set_animation(direction):
	$AnimationPlayer.play("walk")
	$Sprite2D.flip_h = (direction.x == 0 && $Sprite2D.flip_h) || (direction.x > 0)
