extends Node2D

var itemRect = preload("res://Scenes/Level/GUI/Items/item_rect.tscn")

@onready var tree = get_tree()

@onready var player = get_node("Player")
@onready var store  = get_node("Store")

@onready var storeShorts  = get_node("GUILayer/GUI/StoreShortcuts")
@onready var storeDetails = get_node("GUILayer/GUI/StorePanel/CenterContainer/FlowContainer")

@onready var labelTimer = get_node("GUILayer/GUI/LabelTimer")
@onready var labelCoins = get_node("GUILayer/GUI/LabelCoins")

@onready var deathPanel  = get_node("GUILayer/GUI/DeathPanel")
@onready var labelResult = get_node("GUILayer/GUI/DeathPanel/CenterContainer/FlowContainer/lbl_Result")
@onready var sndVictory  = get_node("GUILayer/GUI/DeathPanel/snd_victory")
@onready var sndLose     = get_node("GUILayer/GUI/DeathPanel/snd_lose")

@onready var pausePanel = get_node("GUILayer/GUI/PausePanel")


@onready var pausePanels = [
	get_node("GUILayer/GUI/StorePanel"),
	get_node("GUILayer/GUI/PausePanel")
]

var _time = 0

func _ready():
	# Addings item to gui stores
	var shortcut
	var details
	
	for item in store.get_children():
		# Shortcuts
		shortcut = itemRect.instantiate()
		shortcut.item = item
		
		storeShorts.add_child(shortcut)
	
		# Details
		details = itemRect.instantiate()
		details.item = item
		
		storeDetails.add_child(details)
	
	# Connections
	store.connect_player(player)
	
	# Game initialization
	player.coins = 1000
	store.get_item("Ice Spear").upgrade()

func _process(_delta):
	pass

func _unhandled_input(event):
	if not deathPanel.visible and event is InputEventKey and event.is_pressed():
		if tree.paused:
			#close
			if event.keycode == KEY_ESCAPE:
				for panel in pausePanels:
					panel.visible = false
	
				tree.paused = false
				
			else:
				for panel in pausePanels:
					if panel.open_input.keycode == event.keycode:
						panel.visible = not panel.visible
						tree.paused   =     panel.visible
					else:
						panel.visible = false
				
		else:
			# Open
			for panel in pausePanels:
				if panel.open_input.keycode == event.keycode:
					panel.visible = true
					tree.paused = true
					break

func update_time(argtime = 0):
	_time = argtime
	
	var minutes  = int(_time / 60.0)
	var secondes = _time % 60

	if minutes < 10:
		minutes = str(0, minutes)
	if secondes < 10:
		secondes = str(0, secondes)

	labelTimer.text = str(minutes, ":", secondes)

func display_coins(_old_value, coins):
	labelCoins.text = str(coins, " nok")

func _on_end_level():
	deathPanel.visible = true
	tree.paused = true
	
	if _time >= 300:
		labelResult.text = "You Win"
		sndVictory.play()
	else:
		labelResult.text = "You Lose"
		sndLose.play()
