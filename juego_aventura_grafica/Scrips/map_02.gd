extends Node2D

func _ready():
	var from_scene = GAMESTATE.previous_scene.get_file().get_basename()
	var marker_name = "entry_from_%s" % from_scene

	if has_node(marker_name):
		$Player.global_position = get_node(marker_name).global_position
	else:
		print("No se encontró punto de entrada desde:", from_scene)
