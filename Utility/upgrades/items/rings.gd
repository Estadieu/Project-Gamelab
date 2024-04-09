extends Node

const ICON_PATH = "res://Textures/Items/Upgrades/"

@onready var config = {
	"icon": ICON_PATH + "urand_mage.png",
	"displayname": "Ring",
	"type": "upgrade",
	
	"default_level": {
		"max_level": 5,
		"details": "Your spells now spawn 1 more additional attack",
		"update": func (player, _stats):
			player.stats['additional_attacks'] += 1,
	},

	"levels": {}
}

