extends Node2D

func _ready():
	handle_fade()

func handle_fade():
	if not GAMESTATE.coming_from_cinematic:
		SCREENFADER.fade_out(0.0)
		await SCREENFADER.fade_in(0.5)
	else:
		await SCREENFADER.fade_in(3.0)
		GAMESTATE.coming_from_cinematic = false

func setup_player():
	pass

func move_player_to_entry_point():
	var from_scene = GAMESTATE.previous_scene.get_file().get_basename()
	var marker_name = "entry_from_%s" % from_scene
	if has_node(marker_name):
		var marker = get_node(marker_name)
		var player = $Player
		player.global_position = marker.global_position
		var viewport_center_x = get_viewport_rect().size.x / 2
		player.facing_right = marker.position.x < viewport_center_x
		player.get_node("AnimatedSprite2D").flip_h = not player.facing_right
	else:
		print("No se encontró punto de entrada desde:", from_scene)
