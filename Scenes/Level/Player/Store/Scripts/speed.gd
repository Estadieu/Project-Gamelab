extends Item

func _init():
	super._init("res://Textures/Items/Upgrades/boots_4_green.png", "Speed")

	default_level = {
		"max_level": 10,
		"price": 1,
		"details": "Movement Speed Increased by 50% of base speed",
		"update": func (): player.stats['movement_speed'] += 15.0,
	}
