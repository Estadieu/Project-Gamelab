extends Item

func _init():
	super._init("res://Textures/Items/Upgrades/urand_mage.png", "Ring")

	default_level = {
		"max_level": 5,
		"price": 1,
		"details": "Your spells now spawn 1 more additional attack",
		"update": func (): player.add_stats('additional_attacks', 1),
	}
