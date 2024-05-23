extends Node2D

func _on_coins_updated(coins):
	for child in get_children():
		child.locked = child.level >= child.max_level || coins < child.price
