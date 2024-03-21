extends Timer

signal start_signal()
signal attack_signal()
signal end_signal()

@onready var attack = get_node('AttackTimer')

var bite = "bite"
var ammo = 0

func _on_start_timeout():
	stop()
	emit_signal("start_signal")
	_on_attack_timeout()

func _on_attack_timeout():
	if ammo > 0:
		emit_signal("attack_signal")
		ammo -= 1
		
	if ammo > 0:
		attack.start()
	else:
		attack.stop()
		
		emit_signal("end_signal")
		start()
