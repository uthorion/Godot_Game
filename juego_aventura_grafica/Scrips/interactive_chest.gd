extends StaticBody2D

const CURSOR_LUPA = preload("res://UI/Cursor/lupa.png")
var mensaje = "Hola, soy un cofre."

@onready var area = $Area2D

func _ready():
	pass

func _on_area_2d_mouse_entered():
	Input.set_custom_mouse_cursor(CURSOR_LUPA)

func _on_area_2d_mouse_exited():
	Input.set_custom_mouse_cursor(null)
