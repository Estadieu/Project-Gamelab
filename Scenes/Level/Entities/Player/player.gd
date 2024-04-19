extends CharacterBody2D

#UPGRADES
var _time = 0

var _stats = {
	'movement_speed': 40.0,
	'last_movement': Vector2.UP,

	'hp': 80,
	'maxhp': 80,
	
	'armor': 0,
	
	'speed': 0,
	'spell_cooldown': 0,

	'spell_size': 0,
	'additional_attacks': 0
}

var coins = 0 :
	set(value):
		coins = value
	
		store.set_available_money(coins)
		
		lblMoney.text = str(coins, " nok")

#Enemy Related
var enemy_close = []


@onready var sprite = $Sprite2D
@onready var walkTimer = get_node("%walkTimer")

#GUI
#@onready var itemOptions = preload("res://Scenes/Level/Utility/item_option.tscn")

@onready var store = get_node('GUILayer/GUI/Store')
@onready var lblMoney = get_node("%lbl_money")
@onready var healthBar = get_node("%HealthBar")
@onready var lblTimer = get_node("%lblTimer")

@onready var deathPanel = get_node("%DeathPanel")
@onready var lblResult = get_node("%lbl_Result")
@onready var sndVictory = get_node("%snd_victory")
@onready var sndLose = get_node("%snd_lose")

#Signal
signal playerdeath

signal stats_updated(key, old_value, value)

func _ready():
	store.connect_player(self)
	
	#set_coins(0)
	coins = 1000
	#upgrade_character("icespear", 0)
	store.get_item("Ice Spear").upgrade()

	_on_hurt_box_hurt(0,0,0)

func set_stats(key, value):
	if _stats[key] != value:
		var old_value = _stats[key]

		_stats[key] = value

		emit_signal("stats_updated", key, old_value, value)

func add_stats(key, value): set_stats(key, _stats[key] + value)
	
func get_stats(key):
	return _stats[key]

func _physics_process(_delta):
	movement()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov,y_mov)

	sprite.flip_h = (mov.x == 0 && sprite.flip_h) || (mov.x > 0)

	if mov != Vector2.ZERO:
		_stats['last_movement'] = mov
		if walkTimer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			walkTimer.start()
	
	velocity = mov.normalized() * _stats['movement_speed']
	move_and_slide()

func _on_hurt_box_hurt(damage, _angle, _knockback):
	_stats['hp'] -= clamp(damage - _stats['armor'], 0.0, 999.0)

	healthBar.max_value = _stats['maxhp']
	healthBar.value = _stats['hp']

	if _stats['hp'] <= 0:
		death()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		coins += area.collect()

func change_time(argtime = 0):
	_time = argtime
	
	var get_m = int(_time/60.0)
	var get_s = _time % 60

	if get_m < 10:
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)

	lblTimer.text = str(get_m, ":", get_s)

func death():
	deathPanel.visible = true
	emit_signal("playerdeath")
	get_tree().paused = true
	var tween = deathPanel.create_tween()
	tween.tween_property(deathPanel,"position",Vector2(220,50),3.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	if _time >= 300:
		lblResult.text = "You Win"
		sndVictory.play()
	else:
		lblResult.text = "You Lose"
		sndLose.play()




func _on_btn_menu_click_end():
	get_tree().paused = false
	var _level = get_tree().change_scene_to_file("res://TitleScreen/menu.tscn")
