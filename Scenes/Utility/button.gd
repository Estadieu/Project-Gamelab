extends Button
 # Define a custom signal called "clicked"
signal clicked()

func _on_mouse_entered():
	$SndHover.play()

# Function called when the button is pressed.
func _on_pressed():
	$SndClick.play()

func _on_snd_click_finished():
	emit_signal("clicked")
