extends Item

func _init():
	default_level = {
		"price": 2,
		"details": "Reduces Damage By 1 point",
		"update": func (): player.armor += 1,
	}

