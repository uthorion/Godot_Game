extends Node

func _ready():
	get_tree().paused = false
	if PAUSEMENU:
		PAUSEMENU.hide()
		PAUSEMENU.process_mode = Node.PROCESS_MODE_DISABLED

	GAMESTATE.load_game()
	
func _on_jugar_pressed():
	if PAUSEMENU:
		PAUSEMENU.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().change_scene_to_file("res://Scenes/map_00.tscn")

func _on_salir_pressed():
	get_tree().quit()
