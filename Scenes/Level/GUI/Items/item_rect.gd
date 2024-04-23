class_name ItemRect extends ColorRect

@onready var node_icon        = get_node('Icon')
@onready var node_name        = get_node('Name')
@onready var node_description = get_node('Description')
@onready var node_levelBar    = get_node('LevelBar')

var mouse_over = false

var item = null

func _ready():
	node_name.text    = item.displayname
	node_icon.texture = item.icon
			
	node_levelBar.value     = item.level
	node_levelBar.max_value = item.max_level
	
	item.connect("updated", func (): node_levelBar.value = item.level)

func _input(event):
	if event.is_action_pressed("click") and mouse_over:
		item.upgrade()

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false
