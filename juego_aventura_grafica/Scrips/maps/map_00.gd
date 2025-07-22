extends Node2D

var Start_text = [
	"Despiertas de golpe me medio de una plaza, sientes que algo no va bien",
	"Te tocas el cuerpo y pientas para tu adentro \"¿no estaba en el auto?\"",
	"Te estremeces pero decides que lo mas sensato es buscar algun lugar que te resulte conocido, por lo que empiezas a caminar."
]

func _ready():
	var coming_from_cinematic := false
	
	if not GAMESTATE.coming_from_cinematic:
		SCREENFADER.fade_out(0.0)
		await SCREENFADER.fade_in(0.5)
	else:
		await SCREENFADER.fade_in(3.0)
		GAMESTATE.coming_from_cinematic = false  # Resetearlo para próximas escenas
		
	var from_scene = GAMESTATE.previous_scene.get_file().get_basename()
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
	
	GESTORDIALOGOS.show_external_dialog(Start_text)
	
