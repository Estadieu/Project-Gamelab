extends Node

const ICON_PATH = "res://Textures/Items/Upgrades/"

@onready var config = {
	"icon": ICON_PATH + "helmet_1.png",
	"displayname": "Armor",
	"type": "upgrade",

	"default_level": {
		"max_level": 5,
		"details": "Reduces Damage By 1 point",
		"update": func (player, _stats):
			player.stats['armor'] += 1,
	},

	"levels": {}
}
