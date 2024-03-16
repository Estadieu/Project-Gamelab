extends Node

const ICON_PATH = "res://Textures/Items/Upgrades/"

@onready var config = {
	"icon": ICON_PATH + "helmet_1.png",
	"displayname": "Armor",
	"type": "upgrade",
	
	"init": func (_player, _stats):
		pass,
		
	"attack": func (_player, _stats):
		pass,
	
	"levels": [
		{
			"details": "Reduces Damage By 1 point",
			"update": func (player, _stats):
				player.stats['armor'] += 1,
		},
		{
			"details": "Reduces Damage By an additional 1 point",
			"update": func (player, _stats):
				player.stats['armor'] += 1,
		},
		{
			"details": "Reduces Damage By an additional 1 point",
			"update": func (player, _stats):
				player.stats['armor'] += 1,
		},
		{
			"details": "Reduces Damage By an additional 1 point",
			"update": func (player, _stats):
				player.stats['armor'] += 1,
		},
	]
}
