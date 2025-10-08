extends "res://Scrips/Helpers/map_base.gd"

@export var Start_text = []

@onready var puzzle_manager = $PuzzleManager
@onready var word_label = $CanvasLayer/WordResultLabel

func _ready():
	super()
	setup_player()
	puzzle_manager.puzzle_completed.connect(_on_puzzle_completed)
	$TransitionArea.monitoring = false

func setup_player():
	move_player_to_entry_point()
	GESTORDIALOGOS.show_external_dialog(Start_text)

func _on_puzzle_completed(selected_letters: Array):
	var word = ""
	for l in selected_letters:
		word += l.get_letter()
	word_label.text = word
	word_label.visible = true

	GESTORDIALOGOS.show_external_dialog(["Amor... como pude olvidar el amor que sentia por algo asi. Quizas aun este a tiempo para hacer las paces con mi madre"])

	puzzle_manager.queue_free()
	$TransitionArea.monitoring = true
	


	
