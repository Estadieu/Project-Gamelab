extends Item

func _init():
	default_level = {
		"price": 2,
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"update": func (): player.add_stats('spell_cooldown', 0.05),
	}
	
	levels = {
		'2': {
			"price": 3,
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (): player.add_stats('spell_cooldown', 0.05),
		},
		'3': {
			"price": 5,
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (): player.add_stats('spell_cooldown', 0.05),
		},
		'4': {
			"price": 7,
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (): player.add_stats('spell_cooldown', 0.05),
		},
		'5': {
			"price": 9,
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (): player.add_stats('spell_cooldown', 0.05),
		},
		'6': {
			"price": 11,
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (): player.add_stats('spell_cooldown', 0.05),
		},
		'7': {
			"price": 13,
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (): player.add_stats('spell_cooldown', 0.05),
		},
		'8': {
			"price": 15,
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (): player.add_stats('spell_cooldown', 0.05),
		},
		'9': {
			"price": 17,
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (): player.add_stats('spell_cooldown', 0.05),
		}
	}
