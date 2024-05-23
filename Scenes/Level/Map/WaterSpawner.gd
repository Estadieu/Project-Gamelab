extends Node2D

@export var border_size : int = 512

var water = preload("res://Scenes/Level/Objects/water.tscn")  
var rocks = [
	preload("res://Scenes/Level/Objects/Rock/rock_7.tscn"),
	preload("res://Scenes/Level/Objects/Rock/rock_8.tscn"),  
	preload("res://Scenes/Level/Objects/Rock/rock_9.tscn"), 
	preload("res://Scenes/Level/Objects/Rock/rock_10.tscn"), 
	preload("res://Scenes/Level/Objects/Rock/rock_11.tscn"), 
	preload("res://Scenes/Level/Objects/Rock/rock_12.tscn"),  
	preload("res://Scenes/Level/Objects/Rock/rock_15.tscn"),  
	preload("res://Scenes/Level/Objects/Rock/rock_16.tscn")
]

@onready var bg_size = get_parent().get_parent().region_rect.size

func _ready():
	var half_width  = int(bg_size.x / 2)
	var half_height = int(bg_size.y / 2)
	
	# Water
	for x in range(-half_width - border_size + 32, half_width + border_size, 32):
		# Top
		for y in range(half_height, half_height + border_size, 32): add_water(x, y)
		
		# Bottom
		for y in range(-half_height - border_size + 32, -half_height + 32, 32): add_water(x, y)
			
	for y in range(-half_height - border_size + 32, half_height + border_size, 32):
		# Left
		for x in range(-half_width - border_size + 32, -half_width + 32, 32): add_water(x, y)
			
		# Right
		for x in range(half_width, half_width + border_size, 32): add_water(x, y)

	# Rocks
	for x in range(-half_width, half_width, 32):
		add_rock(x, -half_height + 32 - 16) # Top
		add_rock(x, half_height) # Bottom
		
	for y in range(-half_height, half_height, 32):
		add_rock(-half_width + 32 - 16, y) # Left
		add_rock(half_width - 16, y) # Right

func add_water(x, y):
	var new_water = water.instantiate()
	new_water.position = Vector2(x, y)
	add_child(new_water)
	
func add_rock(x, y):
	var new_rock = rocks[randi() % rocks.size()].instantiate()
	new_rock.position = Vector2(x, y)
	new_rock.scale = Vector2(3, 3)
	get_parent().call_deferred("add_child", new_rock)
