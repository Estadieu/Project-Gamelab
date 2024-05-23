class_name ItemRect extends ColorRect

@onready var node_icon        = $Icon
@onready var node_name        = $Name
@onready var node_description = $Description
@onready var node_levelBar    = $LevelBar
@onready var node_filter      = $Filter

var mouse_over = false

var item = null

func _ready():
	node_name.text      = item.displayname
	node_icon.texture   = item.icon
	node_filter.visible = item.locked
			
	node_levelBar.value     = item.level
	node_levelBar.max_value = item.max_level
	
	item.connect("level_updated", func (): node_levelBar.value = item.level )
	item.connect("lock_updated" , func (): node_filter.visible = item.locked)

func _input(event):
	if event.is_action_pressed("click") and mouse_over:
		item.level += 1

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false
