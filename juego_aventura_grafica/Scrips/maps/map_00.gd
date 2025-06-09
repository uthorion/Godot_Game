extends Node2D

func _ready():
	var from_scene = GAMESTATE.previous_scene.get_file().get_basename()
	GAMESTATE.save_game()
	var marker_name = "entry_from_%s" % from_scene

	if has_node(marker_name):
		var marker = get_node(marker_name)
		var player = $Player

		# Ubicar al jugador en el punto de entrada correcto
		player.global_position = marker.global_position

		var viewport_center_x = get_viewport_rect().size.x / 2

		if marker.position.x < viewport_center_x:
			player.facing_right = true
			player.get_node("AnimatedSprite2D").flip_h = false
		else:
			player.facing_right = false
			player.get_node("AnimatedSprite2D").flip_h = true
	else:
		print("No se encontró punto de entrada desde:", from_scene)
