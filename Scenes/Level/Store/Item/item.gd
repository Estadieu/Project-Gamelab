extends ColorRect

class_name Item

@onready var node_name        = get_node('Name')
@onready var node_description = get_node('Description')
@onready var node_levelBar    = get_node('LevelBar')
@onready var node_icon        = get_node('Icon')

var mouse_over = false

var icon
var displayname

var level = 0

var default_level = {}
var levels        = {}

var player = null
var locked = true

func _init(p_icon = null, p_displayname = null):
	if p_icon == null or p_displayname == null:
		# TODO: default values
		return
	
	icon        = p_icon
	displayname = p_displayname
	
func _ready():
	node_name.text    = displayname
	node_icon.texture = load(icon)
	
	node_levelBar.value     = level
	node_levelBar.max_value = default_level['max_level'] if default_level != null else len(levels)
	
func connect_player(p_player):
	player = p_player
	
func get_level_config(value):
	var config = null

	if str(value) in levels:
		config = levels[str(value)]

	elif default_level != null and value < default_level['max_level']:
		config = default_level

	return config

func upgrade():
	var config = get_level_config(level)

	if not locked and config != null:
		level += 1
		node_levelBar.value = level
		
		config['update'].call()
		
		player.coins -= config.price

func _input(event):
	if event.is_action_pressed("click") and mouse_over:
		upgrade()

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false
