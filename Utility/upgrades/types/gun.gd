extends Node

var attack_timer = preload("res://Utility/attack_timer.tscn")

@onready var config = {
	"init": func (player, stats):
		stats['baseammo'] = 0
		
		stats['timer'] = attack_timer.instantiate()
		
		var _on_start = func ():
			if stats['level'] > 0:
				stats['timer'].ammo = stats['baseammo'] + player.stats['additional_attacks']
		
		var _on_end = func ():
			stats['timer'].wait_time = stats['attackspeed'] * max(1 - player.stats['spell_cooldown'], 0.01)
		
		var _on_attack = func ():
			var bullet = stats['bullet'].instantiate()
			bullet.position = player.position
			
			if 'target' in bullet:
				bullet.target = player.get_random_target()

			if 'last_movement' in bullet:
				bullet.last_movement = player.stats['last_movement']
				
			bullet.level = stats['level']
			
			player.add_child(bullet)
			
		
		stats['timer'].connect("start_signal" , _on_start )
		stats['timer'].connect("attack_signal", _on_attack)
		stats['timer'].connect("end_signal"   , _on_end   )
		
		player.attackNode.add_child(stats['timer'])
		
		stats['timer'].start(),
		
		
	"attack": func (player, stats):
		pass,
}
