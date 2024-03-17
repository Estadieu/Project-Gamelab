extends Node

const WEAPON_PATH = "res://Textures/Items/Weapons/"

var iceSpear = preload("res://Player/Attack/ice_spear.tscn")

@onready var config = {
	"icon": WEAPON_PATH + "ice_spear.png",
	"displayname": "Ice Spear",
	"type": "gun",

	"init": func (player, stats):
		stats['attackspeed'] = 1.5
		stats['bullet'] = iceSpear,
		
	"attack": func (player, _stats):
		pass,

	"levels": [
		{
			"details": "A spear of ice is thrown at a random enemy",
			"update": func (_player, stats):
				stats['baseammo'] += 1,
		},
		{
			"details": "An addition Ice Spear is thrown",
			"update": func (_player, stats):
				stats['baseammo'] += 1,
		},
		{
			"details": "Ice Spears now pass through another enemy and do + 3 damage",
			"update": func (_player, _stats):
				pass,
		},
		{
			"details": "An additional 2 Ice Spears are thrown",
			"update": func (_player, stats):
				stats['baseammo'] += 2,
		}
	]
}
