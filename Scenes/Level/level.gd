extends Node2D

# TODO: Start timers when lvl 1 weapons / No enemies

@onready var tree = get_tree()

@onready var PausePanel = $GUILayer/GUI/PausePanel
@onready var StorePanel = $GUILayer/GUI/StorePanel
@onready var pauseablePanels = [ PausePanel, StorePanel ]

@onready var time = 0 :
	set(value):
		time = value
		
		var component = 1.0 - time / 270.0
		$Map/CanvasModulate.color = Color(component, component, component)
		$Map/SortLayer/Player/PointLight2D .energy = 1.0 - component
	
		emit_signal("time_updated", time)
		$Timer.start()

signal time_updated(time)

func _ready():
	time = 0

func _on_timer_timeout():
	time += 1
	
func _on_coins_updated(coins):
	$GUILayer/GUI/Coins.text = str(coins) + " nok"

func _on_game_end():
	$GUILayer/GUI/ResultPanel.open(time)
	

# TODO: Maybe move this in an another file
func _unhandled_input(event):
	if not $GUILayer/GUI/ResultPanel.visible and event is InputEventKey and event.is_released():
		var i = 0
		while i < len(pauseablePanels) and pauseablePanels[i].open_input.keycode != event.keycode:
			i += 1
			
		if i < len(pauseablePanels):
			var open = pauseablePanels[i].visible

			for panel in pauseablePanels:
				panel.visible = false

			pauseablePanels[i].visible = not open
			tree.paused = pauseablePanels[i].visible
