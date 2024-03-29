extends CharacterBody2D

#UPGRADES
var items_nodes = {}

var stats = {
	'time': 0,

	'movement_speed': 40.0,
	'last_movement': Vector2.UP,

	'hp': 80,
	'maxhp': 80,
	
	'coins': 0,
	
	'armor': 0,
	
	'speed': 0,
	'spell_cooldown': 0,

	'spell_size': 0,
	'additional_attacks': 0
}
var inventory = {}

#Enemy Related
var enemy_close = []


@onready var sprite = $Sprite2D
@onready var walkTimer = get_node("%walkTimer")

#GUI
@onready var itemOptions = preload("res://Utility/item_option.tscn")

@onready var store = get_node('%ItemStore')
@onready var lblMoney = get_node("%lbl_money")
@onready var healthBar = get_node("%HealthBar")
@onready var lblTimer = get_node("%lblTimer")
@onready var attackNode = get_node("%Attack")

@onready var deathPanel = get_node("%DeathPanel")
@onready var lblResult = get_node("%lbl_Result")
@onready var sndVictory = get_node("%snd_victory")
@onready var sndLose = get_node("%snd_lose")

#Signal
signal playerdeath

func _ready():
	for i in UpgradeDb.items:
		var item_config = UpgradeDb.items[i]
		
		inventory[i] = {
			'level': 0
		}
		
		UpgradeDb.types[item_config['type']]['init'].call(self, inventory[i])
		item_config['init'].call(self, inventory[i])
		
		items_nodes[i] = itemOptions.instantiate()
		items_nodes[i].item = i
		
		store.add_child(items_nodes[i])
	
	upgrade_character("icespear", 0)

	attack()

	set_coins(0)
	_on_hurt_box_hurt(0,0,0)
	

func _physics_process(_delta):
	movement()

func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov,y_mov)

	sprite.flip_h = (mov.x == 0 && sprite.flip_h) || (mov.x > 0)

	if mov != Vector2.ZERO:
		stats['last_movement'] = mov
		if walkTimer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			walkTimer.start()
	
	velocity = mov.normalized() * stats['movement_speed']
	move_and_slide()

func attack():
	for i in UpgradeDb.items:
		if inventory[i]['level'] > 0:
			UpgradeDb.types[UpgradeDb.items[i]['type']]['attack'].call(self, inventory[i])
			UpgradeDb.items[i]['attack'].call(self, inventory[i])

func _on_hurt_box_hurt(damage, _angle, _knockback):
	stats['hp'] -= clamp(damage - stats['armor'], 0.0, 999.0)

	healthBar.max_value = stats['maxhp']
	healthBar.value = stats['hp']

	if stats['hp'] <= 0:
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
		add_coins(area.collect())

func add_coins(amount):
	set_coins(stats['coins'] + amount)

func set_coins(coins):
	stats['coins'] = coins
	
	lblMoney.text = str(coins, " nok")

func upgrade_character(upgrade, current_level):
	var next_level = current_level + 1
	
	if current_level < len(UpgradeDb.items[upgrade]['levels']):
		inventory[upgrade]['level'] = next_level
		items_nodes[upgrade].levelBar.value = next_level
		
		UpgradeDb.items[upgrade]['levels'][current_level]['update'].call(self, inventory[upgrade])

		attack()

func change_time(argtime = 0):
	stats['time'] = argtime
	
	var get_m = int(stats['time']/60.0)
	var get_s = stats['time'] % 60

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
	if stats['time'] >= 300:
		lblResult.text = "You Win"
		sndVictory.play()
	else:
		lblResult.text = "You Lose"
		sndLose.play()


func _on_btn_menu_click_end():
	get_tree().paused = false
	var _level = get_tree().change_scene_to_file("res://TitleScreen/menu.tscn")
