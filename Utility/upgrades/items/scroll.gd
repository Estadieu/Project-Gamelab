extends Node

const ICON_PATH = "res://Textures/Items/Upgrades/"

@onready var config = {
	"icon": ICON_PATH + "scroll_old.png",
	"displayname": "Scroll",
	"type": "upgrade",
	
	"default_level": {
		"max_level": 10,
		"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
		"update": func (player, _stats):
			player.stats['spell_cooldown'] += 0.05,
	},
		
	"levels": {}
}
