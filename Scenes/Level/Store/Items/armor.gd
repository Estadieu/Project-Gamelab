extends Item

func _init():
	default_level = {
		"price": 1,
		"details": "Reduces Damage By 1 point",
		"update": func (): player.armor += 1,
	}

