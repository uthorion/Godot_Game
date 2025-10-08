extends Control

@onready var image: TextureRect = $TextureRect
@onready var timer: Timer = $Timer
@onready var cinematic_label: RichTextLabel = $CinematicLabel

@export var cinematic_image: Texture2D = preload("res://Assets/Cinematics/Recuerdo leve.png")

@export var dialog = []

var Actual_dialog = 0

func _ready():
	var cinematic_label = $CinematicText
	GESTORDIALOGOS.set_external_text_target(cinematic_label)
	
	SCREENFADER.fade_out(0.0)
	await get_tree().create_timer(1.0).timeout
	await SCREENFADER.fade_in(1.5)
	timer.start(2.5)

func show_next_dialog():
	if Actual_dialog < dialog.size():
		if Actual_dialog == 2:
			GESTORDIALOGOS.end_dialog()

		GESTORDIALOGOS.show_external_dialog([dialog[Actual_dialog]])
		Actual_dialog += 1
		timer.start(4.0)
	else:
		end_cinematc()
		

func _on_timer_timeout():
	show_next_dialog()

func end_cinematc():
	GESTORDIALOGOS.end_dialog()
	print("Marcando cinematic como true")
	GAMESTATE.coming_from_cinematic = true
	print("Valor GAMESTATE:", GAMESTATE.coming_from_cinematic)

	await get_tree().create_timer(1.5).timeout 
	await SCREENFADER.fade_out(2.0)
	get_tree().change_scene_to_file("res://Scenes/Maps/map_3.tscn")

	
