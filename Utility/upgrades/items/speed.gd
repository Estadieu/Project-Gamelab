extends Node

const ICON_PATH = "res://Textures/Items/Upgrades/"

@onready var config = {
	"icon": ICON_PATH + "boots_4_green.png",
	"displayname": "Speed",
	"type": "upgrade",
	
	"init": func (_player, _stats):
		pass,
		
	"attack": func (_player, _stats):
		pass,
		
		"default_level":{
			"max_level": 10,
			"details": "Movement Speed Increased by 50% of base speed",
			"update": func (player, _stats):
				player.stats['movement_speed'] += 15.0,
		},
	
	"levels": 
		{}
}
