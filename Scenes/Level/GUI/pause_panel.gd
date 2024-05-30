extends Panel

# Key to open/close the linked menu
@export var open_input : InputEventKey = null

@onready var tree = get_tree()


# -- Buttons helpers --

var home = "res://Scenes/Home/home.tscn"

func _on_btn_resume_click_end():
	# Resume game
	visible     = false
	tree.paused = false

func _on_btn_restart_click_end():
	# Restart scene
	tree.paused = false
	tree.reload_current_scene()

func _on_btn_exit_click_end():
	# Exit to home page
	tree.paused = false
	tree.change_scene_to_file(home)
