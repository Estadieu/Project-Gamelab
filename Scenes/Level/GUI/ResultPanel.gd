extends Panel

@onready var tree = get_tree()

@onready var results = $CenterContainer/FlowContainer/Results

var home = "res://Scenes/Home/home.tscn"

func open(time):
	# Pause game
	visible     = true
	tree.paused = true
	
	# If you win
	if time >= 300:
		results.text = "You win !!!"
		$SndVictory.play()

	# If you lose
	else:
		results.text = "You lose !!!"
		$SndLose.play()


# -- Buttons actions --

func _on_btn_restart_click_end():
	# Restart scene
	tree.paused = false
	tree.reload_current_scene()

func _on_btn_exit_click_end():
	# Exit to home menu
	tree.paused = false
	tree.change_scene_to_file(home)
