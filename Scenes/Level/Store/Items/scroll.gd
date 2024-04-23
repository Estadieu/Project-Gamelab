extends Item

func _init():
	default_level = {
		"price": 1,
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"update": func (): player.add_stats('spell_cooldown', 0.05),
	}
