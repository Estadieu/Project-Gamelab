extends Enemy

func flip_entity(direction):
	anim.play("Eagle/walk")
	sprite.flip_h = (direction.x == 0 && sprite.flip_h) || (direction.x > 0)
