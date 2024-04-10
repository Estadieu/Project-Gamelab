extends Area2D

func _signal_body_exited(player):
	player.velocity = 0
	pass
