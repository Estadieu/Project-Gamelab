extends Node

const ICON_PATH = "res://Textures/Items/Upgrades/"

@onready var config = {
	"icon": ICON_PATH + "thick_new.png",
	"displayname": "Tome",
	"type": "upgrade",
	
	"init": func (_player, _stats):
		pass,
		
	"attack": func (_player, _stats):
		pass,
		
	"levels": [
		{
			"details": "Increases the size of spells an additional 10% of their base size",
			"update": func (player, _stats):
				player.stats['spell_size'] += 0.10,
		},
		{
			"details": "Increases the size of spells an additional 10% of their base size",
			"update": func (player, _stats):
				player.stats['spell_size'] += 0.10,
		},
		{
			"details": "Increases the size of spells an additional 10% of their base size",
			"update": func (player, _stats):
				player.stats['spell_size'] += 0.10,
		},
		{
			"details": "Increases the size of spells an additional 10% of their base size",
			"update": func (player, _stats):
				player.stats['spell_size'] += 0.10,
		},
	]
}
