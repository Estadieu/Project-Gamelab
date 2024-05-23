extends Control

@export var store : Node2D = null

var short   = preload("res://Scenes/Level/GUI/Items/item_shorts.tscn")
var details = preload("res://Scenes/Level/GUI/Items/item_details.tscn")

@onready var storeShorts  = $StoreShorts/VBoxContainer
@onready var storeDetails = $StorePanel/CenterContainer/FlowContainer

func _ready():
	# Addings item to gui stores
	var new_short
	var new_details
	
	for item in store.get_children():
		# Shortcuts
		new_short = short.instantiate()
		new_short.item = item
		
		storeShorts.add_child(new_short)

		# Details
		new_details = details.instantiate()
		new_details.item = item

		storeDetails.add_child(new_details)
