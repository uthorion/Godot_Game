extends Node

var cursor_default := preload("res://UI/Cursor/Cursor_Base.png")
var cursor_inspect := preload("res://UI/Cursor/Cursor_lupa.png")
var cursor_llave := preload("res://UI/Cursor/Cursor_Llave.png")
var cursor_boca := preload("res://UI/Cursor/Cursor_boca.png")

func _ready():
	set_cursor_default()

func set_cursor_default():
	Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(0, 0))

func set_cursor_inspect():
	Input.set_custom_mouse_cursor(cursor_inspect, Input.CURSOR_ARROW, Vector2(0, 0))

func set_cursor_llave():
	Input.set_custom_mouse_cursor(cursor_llave, Input.CURSOR_ARROW, Vector2(0, 0))

func set_cursor_boca():
	Input.set_custom_mouse_cursor(cursor_boca, Input.CURSOR_ARROW, Vector2(0, 0))
