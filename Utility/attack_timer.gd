extends Timer

signal start_signal()
signal attack_signal()

@onready var attackTimer = get_node('AttackTimer')

var ammo = 0

func _on_timer_timeout():
	emit_signal("start_signal")
	
	attackTimer.start()
	
func _on_attack_timer_timeout():
	if ammo > 0:
		emit_signal("attack_signal")
		
		ammo -= 1
		
		if ammo > 0:
			attackTimer.start()
		else:
			attackTimer.stop()
