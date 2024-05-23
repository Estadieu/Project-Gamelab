extends Button

signal clicked()

func _on_mouse_entered():
	$SndHover.play()

func _on_pressed():
	$SndClick.play()

func _on_snd_click_finished():
	emit_signal("clicked")
