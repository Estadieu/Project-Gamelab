extends Item

func _init():
	default_level = {
		"price": 2,
		"details": "Movement Speed Increased by 50% of base speed",
		"update": func (): player.speed += 15.0,
	}
	
	levels = {
		'2': {
			"price": 3,
			"details": "Movement Speed Increased by 50% of base speed",
			"update": func (): player.speed += 15.0,
		},
		'3': {
			"price": 5,
			"details": "Movement Speed Increased by 50% of base speed",
			"update": func (): player.speed += 15.0,
		},
		'4': {
			"price": 7,
			"details": "Movement Speed Increased by 50% of base speed",
			"update": func (): player.speed += 15.0,
		},
		'5': {
			"price": 9,
			"details": "Movement Speed Increased by 50% of base speed",
			"update": func (): player.speed += 15.0,
		},
		'6': {
			"price": 11,
			"details": "Movement Speed Increased by 50% of base speed",
			"update": func (): player.speed += 15.0,
		},
		'7': {
			"price": 13,
			"details": "Movement Speed Increased by 50% of base speed",
			"update": func (): player.speed += 15.0,
		},
		'8': {
			"price": 15,
			"details": "Movement Speed Increased by 50% of base speed",
			"update": func (): player.speed += 15.0,
		},
		'9': {
			"price": 17,
			"details": "Movement Speed Increased by 50% of base speed",
			"update": func (): player.speed += 15.0,
		}
	}
