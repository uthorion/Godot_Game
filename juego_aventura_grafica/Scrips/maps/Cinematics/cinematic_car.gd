extends Control

@onready var image = $TextureRect
@onready var timer = $Timer

var images = [
	preload("res://Assets/Cinematics/Manejando en la oscuridad.png"),
	preload("res://Assets/Cinematics/Manejando en la oscuridad - Choque.png")
]

var actual_image = 0

@export var dialog = [
	#"Era una noche solitaria, las estrellas me acompañaban pero me sentia vacio",
	#"Me puse a recordar a Lyla... apenas un año de ese fatidico dia, pero aun no podia olvidarlo",
	#"Si tan solo ese dia no hubiera salido...",
	#"Quizas las cosas hoy serian diferentes..."
]

var Actual_dialog = 0

func _ready():
	var cinematic_label = $CinematicText
	GESTORDIALOGOS.set_external_text_target(cinematic_label)
	
	image.texture = images[0]
	SCREENFADER.fade_out(0.0)
	await get_tree().create_timer(1.0).timeout
	await SCREENFADER.fade_in(1.5)
	timer.start(4.0)

func show_next_dialog():
	if Actual_dialog < dialog.size():
		if Actual_dialog == 2:
		
			GESTORDIALOGOS.end_dialog()
			await SCREENFADER.fade_out(1.0)
			actual_image += 1
			if actual_image < images.size():
				image.texture = images[actual_image]
			await get_tree().create_timer(0.2).timeout  
			await SCREENFADER.fade_in(1.0)

		GESTORDIALOGOS.show_external_dialog([dialog[Actual_dialog]])
		Actual_dialog += 1
		timer.start(4.0)
	else:
		end_cinematc()

func _on_timer_timeout():
	show_next_dialog()

func transition_next_image():
	await SCREENFADER.fade_out(1.0)
	actual_image += 1
	if actual_image < images.size():
		image.texture = images[actual_image]
	await SCREENFADER.fade_in(1.0)

func end_cinematc():
	GESTORDIALOGOS.end_dialog()
	print("Marcando cinematic como true")
	GAMESTATE.coming_from_cinematic = true
	print("Valor GAMESTATE:", GAMESTATE.coming_from_cinematic)

	await get_tree().create_timer(1.5).timeout 
	await SCREENFADER.fade_out(2.0)
	get_tree().change_scene_to_file("res://Scenes/Maps/map_0.tscn")
