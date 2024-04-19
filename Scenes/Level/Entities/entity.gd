extends CharacterBody2D

class_name Entity

@export var max_hp : int   = 10
@export var speed  : float = 20.0

@onready var hp = max_hp

func _init():
	pass
