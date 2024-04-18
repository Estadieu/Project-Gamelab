extends Node2D

var player
var inventory = {}

var items_map = {}

@onready var items = get_node("Items")
var itemNode = preload("res://Scenes/Level/Player/Store/Item/item.tscn")

func _ready():
	for child in items.get_children():
		items_map[child.displayname] = child
	
func _process(_delta):
	pass

func mapped_upgrade(item_name, force = false):
	items_map[item_name].upgrade(force)

func set_available_money(coins):
	var level_config

	for child in items.get_children():
		level_config = child.get_next_level_config()
		
		child.lock()
		
		if level_config != null and coins >= level_config.price:
			child.unlock()
