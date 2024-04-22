extends Item

func _init():
	super._init("res://Textures/Items/Upgrades/helmet_1.png", "Armor")

	default_level = {
		"max_level": 5,
		"price": 1,
		"details": "Reduces Damage By 1 point",
		"update": func (): player.armor += 1,
	}

