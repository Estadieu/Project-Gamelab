extends ColorRect

@onready var lblName = $lbl_name
@onready var lblDescription = $lbl_description
@onready var levelBar = $level_bar
@onready var itemIcon = $ItemIcon

var mouse_over = false
var item = null

@onready var player = get_tree().get_first_node_in_group("player")

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_character"))
	
	var config = UpgradeDb.items[item].config

	lblName.text = config["displayname"]
	itemIcon.texture = load(config["icon"])

	levelBar.value = 0
	
	if 'default_level' in config:
		levelBar.max_value = config['default_level']['max_level']
	else:
		levelBar.max_value = len(config['levels'])
	
	#lblDescription.text = UpgradeDb.items[item]["details"]
	#lblLevel.text = UpgradeDb.items[item]["level"]
	#levelBar.value = UpgradeDb.items[item]["level"]
	
func _input(event):
	if event.is_action_pressed("click") and mouse_over:
		emit_signal("selected_upgrade", item, levelBar.value)

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false
