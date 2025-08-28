extends "res://Scrips/Helpers/map_base.gd"

@export var Start_text = []

func _ready():
	super()
	setup_player()

func setup_player():
	move_player_to_entry_point()
	print("Valor en map_0:", GAMESTATE.coming_from_cinematic)
	if GAMESTATE.coming_from_cinematic: 
		GESTORDIALOGOS.show_external_dialog(Start_text)
		GAMESTATE.coming_from_cinematic = false

func _on_button_mouse_entered():
	CURSORMANAGER.set_cursor_mano()

func _on_button_mouse_exited():
	CURSORMANAGER.set_cursor_default()
