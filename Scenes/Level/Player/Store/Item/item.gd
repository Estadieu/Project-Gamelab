extends ColorRect

class_name Item

@onready var lblName = $lbl_name
@onready var lblDescription = $lbl_description
@onready var levelBar = $level_bar
@onready var itemIcon = $ItemIcon

var mouse_over = false

var icon
var displayname

var level  = 0
var stats  = {}

var default_level = null
var levels = {}

var locked = true

@onready var player = get_tree().get_first_node_in_group("player")

func _init(p_icon, p_displayname):
	icon        = p_icon
	displayname = p_displayname
	
func _ready():
	#connect("selected_upgrade", Callable(player, "upgrade_character"))
	
	#var config = UpgradeDb.items[item].config

	lblName.text = displayname
	itemIcon.texture = load(icon)

	levelBar.value = 0
	
	if default_level != null:
		levelBar.max_value = default_level['max_level']
	else:
		levelBar.max_value = len(levels)
	
	#lblDescription.text = UpgradeDb.items[item]["details"]
	#lblLevel.text = UpgradeDb.items[item]["level"]
	#levelBar.value = UpgradeDb.items[item]["level"]
	
func get_next_level_config():
	var level_config = null

	if default_level != null:

		if str(level) in levels:
			level_config = levels[str(level)]

		elif level < default_level['max_level']:
			level_config = default_level

	elif level < len(levels):
		level_config = levels[level]
		
	return level_config
	
	
func upgrade(force = false):
	var next_level = level + 1
	var level_config = get_next_level_config()

	if force or (level_config != null and not locked):
		level = next_level
		levelBar.value = next_level
		
		level_config['update'].call()
		
		player.coins -= level_config.price
		player.attack()
		
	
func _input(event):
	if event.is_action_pressed("click") and mouse_over:
		upgrade()

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false

func lock():
	locked = true

func unlock():
	locked = false
