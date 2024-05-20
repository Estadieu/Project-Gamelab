extends Item

func _init():
	default_level = {
		"price": 2,
		"details": "Increases the size of spells an additional 10% of their base size",
		"update": func (): player.add_stats('spell_size', 0.10),
	}
	
	levels = {
		'2': {
			"price": 3,
			"details": "Increases the size of spells an additional 10% of their base size",
			"update": func (): player.add_stats('spell_size', 0.10),
		},
		'3': {
			"price": 5,
			"details": "Increases the size of spells an additional 10% of their base size",
			"update": func (): player.add_stats('spell_size', 0.10),
		},
		'4': {
			"price": 7,
			"details": "Increases the size of spells an additional 10% of their base size",
			"update": func (): player.add_stats('spell_size', 0.10),
		}
	}
