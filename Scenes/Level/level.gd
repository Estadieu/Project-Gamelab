extends Node2D

@onready var tree = get_tree()

@onready var player = get_node("Player")
@onready var store  = get_node("GUILayer/GUI/Store")

@onready var labelTimer = get_node("GUILayer/GUI/LabelTimer")
@onready var labelCoins = get_node("GUILayer/GUI/LabelCoins")

@onready var deathPanel  = get_node("GUILayer/GUI/DeathPanel")
@onready var labelResult = get_node("GUILayer/GUI/DeathPanel/lbl_Result")
@onready var sndVictory  = get_node("GUILayer/GUI/DeathPanel/snd_victory")
@onready var sndLose     = get_node("GUILayer/GUI/DeathPanel/snd_lose")

@onready var pausePanel = get_node("GUILayer/GUI/PausePanel")

var _time = 0

func _ready():
	store.connect_player(player)
	
	player.coins = 1000
	
	store.get_item("Ice Spear").upgrade()

func _process(_delta):
	pass

func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ESCAPE:
		pausePanel.visible = not tree.paused
		tree.paused        = not tree.paused

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
	get_tree().paused = true

	var tween = deathPanel.create_tween()
	tween \
		.tween_property(deathPanel, "position", Vector2(220,50), 3.0) \
		.set_trans(Tween.TRANS_QUINT) \
		.set_ease(Tween.EASE_OUT)
	tween.play()
	
	if _time >= 300:
		labelResult.text = "You Win"
		sndVictory.play()
	else:
		labelResult.text = "You Lose"
		sndLose.play()
