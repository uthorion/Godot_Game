extends CanvasLayer

func _on_llave_pressed():
	queue_free()  # Quita la llave de la escena

func _on_cerrar_pressed():
	queue_free()  # Cierra la escena de detalle
