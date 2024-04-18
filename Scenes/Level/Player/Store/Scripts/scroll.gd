extends Item

func _init():
	super._init("res://Textures/Items/Upgrades/scroll_old.png", "Scroll")

	default_level = {
		"max_level": 10,
		"price": 1,
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"update": func (): player.stats['spell_cooldown'] += 0.05,
	}
