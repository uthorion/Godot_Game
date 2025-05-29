extends Area2D

func _on_mouse_entered():
	CURSORMANAGER.set_cursor_mano()

func _on_mouse_exited():
	CURSORMANAGER.set_cursor_default()
