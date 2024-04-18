extends Gun

func _init():
	super._init(
		"res://Textures/Items/Weapons/snowball.png",
		"Snow ball",
		"res://Scenes/Level/Player/Attack/bullet/snowball.tscn"
	)

	default_level = {
		"max_level": 5,
		"price": 1,
		"details": "A snowball is created and random heads somewhere in the players direction",
		"update": func (): base_ammo += 1,
	}
	
	levels = {
		'2': {
			"price": 1,
			"details": "The snow ball cooldown is reduced by 0.5 seconds",
			"update": func (): stats['burst_cooldown'] += 1,
		},
		'4': {
			"price": 1,
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

