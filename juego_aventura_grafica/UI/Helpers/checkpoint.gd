extends StaticBody2D

@onready var area = $Area2D

var dialog_checkpoint = [
	{
		"text": "¿Deseás guardar la sesión?",
		"options": [
			{"text": "Sí", "next": -1},
			{"text": "No", "next": -1}
		]
	},
	"Juego guardado."
]

func _ready():
	area.input_event.connect(_on_area_input)

func _on_area_input(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GESTORDIALOGOS.show_external_dialog(dialog_checkpoint.duplicate(true))
		GESTORDIALOGOS.dialog_completed_callback = save_after_confirmation

func save_after_confirmation(index: int):
	# Si el jugador eligió la primera opción (índice 0), guarda.
	print("🟢 save_after_confirmation ejecutado con índice:", index)
	if index == 0:
		GAMESTATE.save_game()
		GESTORDIALOGOS.show_external_dialog(["Juego guardado."])
