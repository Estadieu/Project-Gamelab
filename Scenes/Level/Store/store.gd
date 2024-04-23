extends Node2D

var items_map = {}

func _ready():
	for child in get_children():
		items_map[child.displayname] = child

func get_item(item_name):
	return items_map[item_name]

func connect_player(p_player):
	p_player.connect("coins_updated", Callable(self, "set_available_coins"))
	
	for child in get_children():
		child.player = p_player

func set_available_coins(_old_value, coins):
	var config
	
	for child in get_children():
		config = child.get_level_config(child.level)
		
		child.locked = (config == null or coins < config.price)
