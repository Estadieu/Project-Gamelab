extends Gun

func _init():
	default_level = {
		"price": 4,
		"details": "A snowball is created and random heads somewhere in the players direction",
		"update": func (): base_ammo += 1,
	}
	
	levels = {
		'2': {
			"price": 5,
			"details": "The snow ball cooldown is reduced by 0.5 seconds",
			"update": func (): stats['burst_cooldown'] += 1,
		},
		'3': {
			"price": 10,
			"details": "A snowball is created and random heads somewhere in the players direction",
			"update": func (): base_ammo += 1,
		},
		'4': {
			"price": 15,
			"details": "A snowball is created and random heads somewhere in the players direction",
			"update": func ():
				base_ammo += 1
				stats['knockback_amount'] = 125,
		}
	}

	stats = {
		'burst_cooldown': 3,

		'base_hp': 999,

		'speed': 100.0,
		'damage': 5,
		'knockback_amount': 100,
		
		'attack_size': .75
	}

