extends Control

const level = "res://Scenes/Level/level.tscn"

const sentences = [
	"You're a French student and you've managed to get your Erasmus",
	"Of all the possibilities, you chose...",
	"Norway (yes, it's in the name of the game)",
	"To you the beautiful landscapes, the hikes the forest ",
	"Are you ready ?",
	"Damn, we forgot the no button!",
	"3",
	"2",
	"1",
	"Good luck !"
]

const end_speed_start = 6

var current = 0

@onready var tree = get_tree()

func _ready():
	$Label.text = sentences[current]

func _on_timer_end():
	current += 1

	$Timer.stop()

	if current >= sentences.size():
		tree.change_scene_to_file(level)
		return

	if current == end_speed_start:
		$Timer.wait_time = 0.5

	var tween = create_tween()
	tween.tween_property($Label, "modulate", Color(255, 255, 255, 0.0), 0.5)
	tween.tween_callback(func(): $Label.text = sentences[current])
	tween.tween_property($Label, "modulate", Color(255, 255, 255, 1.0), 0.5)
	tween.tween_callback(func(): $Timer.start())
	tween.play()

func _unhandled_input(event):
	if event is InputEventKey:
		tree.change_scene_to_file(level)
