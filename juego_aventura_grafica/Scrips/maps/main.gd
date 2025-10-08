extends "res://Scrips/Helpers/map_base.gd"
	
func _ready():
	get_tree().paused = false
	if PAUSEMENU:
		PAUSEMENU.hide()
		PAUSEMENU.process_mode = Node.PROCESS_MODE_DISABLED

func _on_jugar_pressed():
	GAMESTATE.new_game()
	if PAUSEMENU:
		PAUSEMENU.process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().change_scene_to_file("res://Scenes/Cinematics/cinematic_car.tscn")

#func _on_cargar_pressed():
	#if GAMESTATE.load_game():
		#var target := GAMESTATE.previous_scene if GAMESTATE.previous_scene != "" else "res://Scenes/Maps/map_0.tscn"
		#get_tree().change_scene_to_file(target)
	#else:
		#print("No hay partida guardada")

func _on_salir_pressed():
	get_tree().quit()


func _on_ayuda_pressed():
	get_tree().change_scene_to_file("res://Scenes/SpecialScenes/ayuda.tscn")
