extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
#	process_mode = Node.PROCESS_MODE_PAUSABLE
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	

func _unhandled_input(event):
	if event is InputEventKey \
#		and event.pressed \
		and event.keycode == KEY_ESCAPE:
			var popup_pause = get_node("PauseMenu")
			var tree = get_tree()
			
			if tree.paused:
				popup_pause.hide()
				tree.paused = false
			else:
				tree.paused = true
				popup_pause.show()
			


func _on_btn_exit_click_end():
	pass # Replace with function body.
