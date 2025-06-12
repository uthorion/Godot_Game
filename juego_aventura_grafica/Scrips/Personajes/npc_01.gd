extends StaticBody2D

@onready var area = $Area2D

var dialogos_npc_01 = [
	"Finalmente has llegado.",
	{
		"texto": "¿Qué quieres hacer?",
		"opciones": [
			{"texto": "Hablar más", "siguiente": 2},
			{"texto": "Irme", "siguiente": -1}
		]
	},
	"Perfecto, sigamos entonces.",
	{
		"texto": "¿Sobre qué quieres hablar?",
		"opciones": [
			{"texto": "Tu pasado", "siguiente": 4},
			{"texto": "Lo que viene", "siguiente": 6},
			{"texto": "Nada, adiós", "siguiente": -1}
		]
	},
	"Mi pasado está lleno de errores y decisiones difíciles...",
	{
		"texto": "¿Te arrepientes?",
		"opciones": [
			{"texto": "Sí", "siguiente": 7},
			{"texto": "No", "siguiente": 8}
		]
	},
	"Lo que viene depende de ti tanto como de mí.",
	"Es difícil no hacerlo, pero he aprendido a vivir con eso.",
	"Entonces debes seguir adelante sin mirar atrás.",
	{
		"texto": "¿Quieres decir algo más?",
		"opciones": [
			{"texto": "Sí", "siguiente": 10},
			{"texto": "No", "siguiente": -1}
		]
	},
	"Entonces escucha con atención: no todo está perdido."
]

func _ready():
	area.input_event.connect(_on_area_input)

func _on_area_input(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GESTORDIALOGOS.mostrar_dialogo_externo(dialogos_npc_01)

func _on_area_2d_mouse_entered():
	CURSORMANAGER.set_cursor_boca()

func _on_area_2d_mouse_exited():
	CURSORMANAGER.set_cursor_default()
