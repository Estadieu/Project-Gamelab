extends Bullet

var target_array = []

var reset_pos = Vector2.ZERO

var spr_jav_reg = preload("res://Textures/Items/Weapons/javelin_3_new.png")
var spr_jav_atk = preload("res://Textures/Items/Weapons/javelin_3_new_attack.png")

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var attackTimer = get_node("%AttackTimer")
@onready var changeDirectionTimer = get_node("%ChangeDirection")
@onready var resetPosTimer = get_node ("%ResetPosTimer")
@onready var snd_attack = $snd_attack

func _ready():
	super._ready()
	update_javelin()
	_on_reset_pos_timer_timeout()

func update_javelin():
	stats['attack_speed'] = 5.0 * (1 - player.get_stats('spell_cooldown'))

	scale = Vector2(1.0,1.0) * stats['attack_size']
	attackTimer.wait_time = stats['attack_speed']

func _physics_process(delta):
	if target_array.size() > 0:
		super._physics_process(delta)
	
	else:
		var player_angle = global_position.direction_to(reset_pos)
		var distance_dif = global_position - player.global_position
		var return_speed = 20

		if abs(distance_dif.x) > 500 or abs(distance_dif.y) > 500:
			return_speed = 100

		position += player_angle * return_speed * delta
		rotation = global_position.direction_to(player.global_position).angle() + deg_to_rad(135)

func add_paths():
	snd_attack.play()
	emit_signal("remove_from_array",self)
	target_array.clear()

	var counter = 0

	while counter < stats['paths']:
		var new_path = player.get_random_target()
		target_array.append(new_path)
		counter += 1

	enable_attack(true)
	target = target_array[0]
	process_path()

func process_path():
	angle = global_position.direction_to(target)

	changeDirectionTimer.start()

	var tween = create_tween()
	var new_rotation_degrees = angle.angle() + deg_to_rad(135)
	tween.tween_property(self,"rotation",new_rotation_degrees,0.25).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()

func enable_attack(atk = true):
	collision.call_deferred("set", "disabled", not atk)
	
	if atk:
		sprite.texture = spr_jav_atk

	else:
		sprite.texture = spr_jav_reg

func _on_attack_timer_timeout():
	add_paths()

func _on_change_direction_timeout():
	if target_array.size() > 0:
		target_array.remove_at(0)
		if target_array.size() > 0:
			target = target_array[0]
			process_path()
			snd_attack.play()
			emit_signal("remove_from_array",self)
		else:
			changeDirectionTimer.stop()
			attackTimer.start()
			enable_attack(false)
	else:
		changeDirectionTimer.stop()
		attackTimer.start()
		enable_attack(false)


func _on_reset_pos_timer_timeout():
	var choose_direction = randi() % 4
	reset_pos = player.global_position
	match choose_direction:
		0:
			reset_pos.x += 50
		1:
			reset_pos.x -= 50
		2:
			reset_pos.y += 50
		3:
			reset_pos.y -= 50
