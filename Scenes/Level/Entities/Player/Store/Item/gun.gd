extends Item

class_name Gun

var stats = {}

var generic_bullet
var generic_timer = preload("res://Scenes/Level/Utility/attack_timer.tscn")

var base_ammo = 0

@onready var timer = get_node('Timer')

func _init(p_icon = null, p_displayname = null, p_bullet = null):
	super._init(p_icon, p_displayname)
	
	if p_bullet == null:
		# TODO: default value
		return
	
	generic_bullet = load(p_bullet)

func _ready():
	super._ready()
	
	timer.connect("start_signal" , _on_start )
	timer.connect("attack_signal", _on_attack)
	timer.connect("end_signal"   , _on_end   )
	
	timer.start()

func _on_start():
		if level > 0:
			timer.ammo = base_ammo + player.get_stats('additional_attacks')
	
func _on_end():
	timer.wait_time = stats['burst_cooldown'] * max(1 - player.get_stats('spell_cooldown'), 0.01)

func _on_attack():
	var bullet = generic_bullet.instantiate()
	bullet.position = player.position
	bullet.stats = stats
	bullet.scale *= Vector2(1,1) * (1 + player.get_stats('spell_size'))
	
	#var tween = create_tween()
	#tween.tween_property(
		#bullet, 
		#"scale",
		#Vector2(1,1) * (1 + player.stats['spell_size']), 
		#1
	#).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	#tween.play()
	
	# TODO: Check bug last movement
	#set_target(bullet)
	
	bullet.target = player.get_random_target()

	player.add_child(bullet)

func set_target(bullet):
	bullet.last_movement = player.stats['last_movement']
