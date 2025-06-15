extends StaticBody2D

@onready var area = $Area2D

var dialogs_npc_01 = [
	"Finalmente has llegado.",
	{
		"text": "¿Qué quieres hacer?",
		"options": [
			{"text": "Hablar más", "next": 2},
			{"text": "Irme", "next": -1}
		]
	},
	"Perfecto, sigamos entonces.",
	{
		"text": "¿Sobre qué quieres hablar?",
		"options": [
			{"text": "Tu pasado", "next": 4},
			{"text": "Lo que viene", "next": 6},
			{"text": "Nada, adiós", "next": -1}
		]
	},
	"Mi pasado está lleno de errores y decisiones difíciles...",
	{
		"text": "¿Te arrepientes?",
		"options": [
			{"text": "Sí", "next": 7},
			{"text": "No", "next": 8}
		]
	},
	"Lo que viene depende de ti tanto como de mí.",
	"Es difícil no hacerlo, pero he aprendido a vivir con eso.",
	"Entonces debes seguir adelante sin mirar atrás.",
	{
		"text": "¿Quieres decir algo más?",
		"options": [
			{"text": "Sí", "next": 10},
			{"text": "No", "next": -1}
		]
	},
	"Entonces escucha con atención: no todo está perdido."
]

func _ready():
	area.input_event.connect(_on_area_input)

func _on_area_input(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GESTORDIALOGOS.show_external_dialog(dialogs_npc_01)

func _on_area_2d_mouse_entered():
	CURSORMANAGER.set_cursor_boca()

func _on_area_2d_mouse_exited():
	CURSORMANAGER.set_cursor_default()
