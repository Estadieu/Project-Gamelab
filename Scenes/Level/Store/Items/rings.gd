extends Item

func _init():
	default_level = {
		"price": 20,
		"details": "Your spells now spawn 1 more additional attack",
		"update": func (): player.add_stats('additional_attacks', 1),
	}
	
	levels = {
		'2': {
			"price": 25,
			"details": "Your spells now spawn 1 more additional attack",
			"update": func (): player.add_stats('additional_attacks', 1),
		},
		'3': {
			"price": 25,
			"details": "Your spells now spawn 1 more additional attack",
			"update": func (): player.add_stats('additional_attacks', 1),
		},
		'4': {
			"price": 30,
			"details": "Your spells now spawn 1 more additional attack",
			"update": func (): player.add_stats('additional_attacks', 1),
		}
	}
