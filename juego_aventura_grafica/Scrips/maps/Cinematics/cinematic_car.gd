extends Control

@onready var image = $TextureRect
@onready var timer = $Timer

# Diálogos que se mostrarán automáticamente
var dialog = [
	"Era una noche solitaria, las estrellas me acompañaban pero me sentia vacio",
	"Me puse a recordar a Lyla... apenas un año de ese fatidico dia, pero aun no podia olvidarlo",
	"Si tan solo ese dia no hubiera salido...",
	"Quizas las cosas hoy serian diferentes..."
]

var Actual_dialog = 0

func _ready():
	image.visible = false
	await SCREENFADER.fade_out(0.0)
	await get_tree().create_timer(1.0).timeout
	SCREENFADER.fade_in(1.5)
	image.visible = true
	show_next_dialog()

func show_next_dialog():
	if Actual_dialog < dialog.size():
		GESTORDIALOGOS.show_external_dialog([dialog[Actual_dialog]])
		Actual_dialog += 1
		timer.start(4.0)  # segundos que dura cada línea (ajustable)
	else:
		end_cinematc()

func end_cinematc():
	GESTORDIALOGOS.end_dialog()
	GAMESTATE.coming_from_cinematic = true
	await SCREENFADER.fade_out(3.0)
	get_tree().change_scene_to_file("res://Scenes/Maps/map_00.tscn")

func _on_timer_timeout():
	show_next_dialog()
