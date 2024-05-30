extends Control

# Path to the level scene
const level = "res://Scenes/Level/level.tscn"

# List of sentences to display in sequence
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

# Index at which the timer speed will change
const end_speed_start = 6

# Variable to keep track of the current sentence index
var current = 0

# Reference to the scene tree
@onready var tree = get_tree()

# Function called when the node is added to the scene
func _ready():
	# Set the label's text to the first sentence in the list
	$Label.text = sentences[current]

# Function called when the timer ends
func _on_timer_end():
	# Increment the current sentence index
	current += 1

	$Timer.stop()

	# If all sentences have been displayed, change to the level scene
	if current >= sentences.size():
		tree.change_scene_to_file(level)
		return

	# If the current index matches end_speed_start, reduce the timer's wait time
	if current == end_speed_start:
		$Timer.wait_time = 0.5

	# Create a new tween
	var tween = create_tween()
	# Fade out the label's text
	tween.tween_property($Label, "modulate", Color(255, 255, 255, 0.0), 0.5)
	# Change the label's text to the next sentence
	tween.tween_callback(func(): $Label.text = sentences[current])
	# Fade in the new label's text
	tween.tween_property($Label, "modulate", Color(255, 255, 255, 1.0), 0.5)
	# Restart the timer
	tween.tween_callback(func(): $Timer.start())
	# Start the tween
	tween.play()

# Function called when an unhandled input event occurs
func _unhandled_input(event):
	# If the input event is a key press, change to the level scene
	if event is InputEventKey:
		tree.change_scene_to_file(level)
