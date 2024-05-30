extends Node2D

# Initializations
@onready var tree = get_tree()

@onready var PausePanel = $GUILayer/GUI/PausePanel
@onready var StorePanel = $GUILayer/GUI/StorePanel
@onready var pauseablePanels = [ PausePanel, StorePanel ]

# Time management
@onready var time = 0 :
	set(value):
		# Save
		time = value

		# Decrease brightness
		if time <= 270:
			var component = 1.0 - time / 270.0
			$Map/CanvasModulate.color = Color(component, component, component) # Decrease brighness
			$Map/SortLayer/Player/PointLight2D .energy = 1.0 - component       # Increase light
	
		# Decrease light
		else:
			$Map/SortLayer/Player/PointLight2D .energy = max(1.0 - (time - 270.0) / 30.0, 0.1)
	
		# End game
		if time > 300:
			$Map/SortLayer/Player.hp = 0

		# Emit & restart timer
		emit_signal("time_updated", time)
		$Timer.start()

signal time_updated(time)

func _ready():
	time = 0

func _on_timer_timeout():
	time += 1
	
func _on_coins_updated(coins):
	# Update coins display
	$GUILayer/GUI/Coins.text = str(coins) + " nok"

func _on_game_end():
	# Open end game panel
	$GUILayer/GUI/ResultPanel.open(time)
	
# Pause menues management
func _unhandled_input(event):
	# If key pressed (execpt during end game)
	if not $GUILayer/GUI/ResultPanel.visible and event is InputEventKey and event.is_released():
		# Search openable/closable pause menu
		var i = 0
		while i < len(pauseablePanels) and pauseablePanels[i].open_input.keycode != event.keycode:
			i += 1
			
		# If a menu was found
		if i < len(pauseablePanels):
			var open = pauseablePanels[i].visible

			# Close all menu
			for panel in pauseablePanels:
				panel.visible = false

			# Reverse targeted menu visibility
			pauseablePanels[i].visible = not open
			tree.paused = pauseablePanels[i].visible
