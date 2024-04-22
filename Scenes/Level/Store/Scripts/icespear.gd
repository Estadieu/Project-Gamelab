extends Gun

func _init():
	super._init(
		"res://Textures/Items/Weapons/ice_spear.png", 
		"Ice Spear",
		"res://Scenes/Level/Store/Objects/ice_spear.tscn"
	)

	default_level = {
		"max_level": 4,
		"price": 2,
		"details": "A spear of ice is thrown at a random enemy",
		"update": func (): base_ammo += 1,
	}

	levels = {
		'0': {
			"price": 0,
			"details": "A spear of ice is thrown at a random enemy",
			"update": func (): base_ammo += 1,
		},
		'2': {
			"price": 4,
			"details": "Ice Spears now pass through another enemy and do + 3 damage",
			"update": func ():
				stats['base_hp']  = 2
				stats['damage' ] += 3,
		},
		'3': {
			"price": 10,
			"details": "An additional 2 Ice Spears are thrown",
			"update": func (): base_ammo += 2,
		}
	}
	
	stats = {
		'burst_cooldown': 1.5,

		'base_hp': 1,

		'speed': 100,
		'damage': 5,
		'knockback_amount': 100,
		
		'attack_size': 1.0
	}

func set_target(bullet):
	bullet.target = player.get_random_target()
