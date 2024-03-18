extends Node

const ICON_PATH = "res://Textures/Items/Upgrades/"

@onready var config = {
	"icon": ICON_PATH + "scroll_old.png",
	"displayname": "Scroll",
	"type": "upgrade",
	
	"init": func (_player, _stats):
		pass,
		
	"attack": func (_player, _stats):
		pass,
		
	"levels": [
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
		{
			"details": "Decreases of the cooldown of spells by an additional 5% of their base time",
			"update": func (player, _stats):
				player.stats['spell_cooldown'] += 0.05,
		},
	]
}
