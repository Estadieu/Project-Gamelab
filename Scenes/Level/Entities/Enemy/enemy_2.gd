extends Enemy

func _init():
	super._init()
	
	_stats['damage'] = 1
	_stats['experience'] = 1

	_stats['knockback'] = Vector2.ZERO
	_stats['knockback_recovery'] = 3.5
