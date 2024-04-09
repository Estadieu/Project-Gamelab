extends Node

var attack_timer = preload("res://Utility/attack_timer.tscn")

func init(player, stats):
	stats['baseammo'] = 0
	
	stats['timer'] = attack_timer.instantiate()
	
	var _on_start = func ():
		if stats['level'] > 0:
			stats['timer'].ammo = stats['baseammo'] + player.stats['additional_attacks']
	
	var _on_end = func ():
		stats['timer'].wait_time = stats['burst_cooldown'] * max(1 - player.stats['spell_cooldown'], 0.01)
	
	var _on_attack = func ():		
		var bullet = stats['bullet'].instantiate()
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
		
		if 'target' in bullet:
			bullet.target = player.get_random_target()

		if 'last_movement' in bullet:
			bullet.last_movement = player.stats['last_movement']
		
		player.add_child(bullet)
		
	
	stats['timer'].connect("start_signal" , _on_start )
	stats['timer'].connect("attack_signal", _on_attack)
	stats['timer'].connect("end_signal"   , _on_end   )
	
	player.attackNode.add_child(stats['timer'])
	
	stats['timer'].start()
