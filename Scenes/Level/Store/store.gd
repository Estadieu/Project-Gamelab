extends Node2D

var player = null

var items_map = {}

@onready var items = get_node("Items")
var itemNode = preload("res://Scenes/Level/Store/Item/item.tscn")

func _ready():
	for child in items.get_children():
		items_map[child.displayname] = child

func connect_player(p_player):
	player = p_player
	
	player.connect("coins_updated", Callable(self, "set_available_coins"))
	
	for child in items.get_children():
		child.connect_player(p_player)

func _process(_delta):
	pass

func get_item(item_name):
	return items_map[item_name]

func set_available_coins(_old_value, coins):
	var config
	
	for child in items.get_children():
		config = child.get_level_config(child.level)
		
		child.locked = (config == null or coins < config.price)
