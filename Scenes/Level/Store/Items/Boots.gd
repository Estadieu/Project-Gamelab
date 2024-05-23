extends Item

func get_price(lvl): return 10 * lvl + 10

func _init():
	default_level = {
		"details": "Movement Speed Increased by 50% of base speed",
		"update": func (): player.speed += 16.0,
	}

