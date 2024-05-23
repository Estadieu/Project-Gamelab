extends Panel

@export var open_input : InputEventKey = null

@onready var tree = get_tree()

@onready var results = $CenterContainer/FlowContainer/Results

var home = "res://Scenes/Home/home.tscn"

func open(time):
	visible     = true
	tree.paused = true
	
	if time >= 300:
		results.text = "You win !!!"
		$SndVictory.play()
	else:
		results.text = "You lose !!!"
		$SndLose.play()

func _on_btn_restart_click_end():
	tree.paused = false
	tree.reload_current_scene()

func _on_btn_exit_click_end():
	tree.paused = false
	tree.change_scene_to_file(home)
