class_name Gun extends Item

var generic_bullet
var generic_timer = preload("res://Scenes/Level/Utility/attack_timer.tscn")

var timer
var base_ammo = 0

func _init(p_icon, p_displayname, p_bullet):
	super._init(p_icon, p_displayname)
	
	generic_bullet = load(p_bullet)

func _ready():
	super._ready()
	
	timer = generic_timer.instantiate()

	var _on_start = func ():
		if level > 0:
			timer.ammo = base_ammo + player.stats['additional_attacks']
	
	var _on_end = func ():
		timer.wait_time = stats['burst_cooldown'] * max(1 - player.stats['spell_cooldown'], 0.01)
	
	var _on_attack = func ():		
		var bullet = generic_bullet.instantiate()
		bullet.position = player.position
		bullet.stats = stats
		bullet.scale *= Vector2(1,1) * (1 + player.stats['spell_size'])
		
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
		
	
	timer.connect("start_signal" , _on_start )
	timer.connect("attack_signal", _on_attack)
	timer.connect("end_signal"   , _on_end   )
	
	add_child(timer)
	
	timer.start()

func set_target(bullet):
	bullet.last_movement = player.stats['last_movement']
