extends Item

func _init():
	default_level = {
		"price": 2,
		"details": "Movement Speed Increased by 50% of base speed",
		"update": func (): player.speed += 15.0,
	}
