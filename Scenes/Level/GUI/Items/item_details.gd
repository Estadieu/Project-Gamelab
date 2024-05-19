class_name ItemDetails extends ColorRect

@onready var node_icon        = get_node('Icon')
@onready var node_name        = get_node('Name')
@onready var node_description = get_node('Description')
@onready var node_levelBar    = get_node('LevelBar')
@onready var node_price       = get_node('Price')
@onready var node_filter      = get_node('Filter')

var mouse_over = false

var item = null

func _ready():
	var config = item.get_level_config(item.level)
	
	node_icon.texture     = item.icon
	node_name.text        = item.displayname
	node_description.text = config['details']
	node_price.text       = str(config['price'  ], " nok")
			
	node_levelBar.value     = item.level
	node_levelBar.max_value = item.max_level
	
	item.connect("updated", func (): 
		node_levelBar.value = item.level
		
		config = item.get_level_config(item.level)
		
		if config != null:
			node_description.text = config['details']
			node_price.text = str(config['price'], " nok")
		else:
			node_description.text = ""
			node_price.text = ""
	)
	item.connect("lock_updated" , func (): node_filter.visible = item.locked)

func _input(event):
	if event.is_action_pressed("click") and mouse_over:
		item.upgrade()

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false
