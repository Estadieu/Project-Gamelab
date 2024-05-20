extends Item

func _init():
	default_level = {
		"price": 2,
		"details": "Reduces Damage By 1 point",
		"update": func (): player.armor += 1,
	}
	
	levels = {
		'2': {
			"price": 3,
			"details": "Reduces Damage By 1 point",
			"update": func (): player.armor += 1,
		},
		'3': {
			"price": 5,
			"details": "Reduces Damage By 1 point",
			"update": func (): player.armor += 1,
		},
		'4': {
			"price": 7,
			"details": "Reduces Damage By 1 point",
			"update": func (): player.armor += 1,
		}
	}

