extends Control

@onready var rich_text = $MarginContainer/Dialogos

var dialogos = [
	"Hola, ¿cómo estás?",
	"Hace mucho que no nos veíamos...",
	"¿Recuerdas la vieja casa donde crecimos?",
	"Tengo algo importante que contarte."
]
var current_dialog_index = 0
var escribiendo = false
var texto_completo = ""

func _ready():
	rich_text.clear()
	mostrar_dialogo()

func mostrar_dialogo():
	if current_dialog_index < dialogos.size():
		texto_completo = dialogos[current_dialog_index]
		current_dialog_index += 1
		escribir_texto(texto_completo)
	else:
		print("Fin del diálogo")
		
func escribir_texto(texto):
	$MarginContainer/Dialogos.clear()
	escribiendo = true
	await mostrar_texto_letra_por_letra(texto)
	escribiendo = false


func _on_control_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if escribiendo:
			# Si el jugador hace clic mientras se escribe, mostrar el texto completo al instante
			$MarginContainer/Dialogos.text = texto_completo
			escribiendo = false
		else:
			mostrar_dialogo()
			
func mostrar_texto_letra_por_letra(texto: String) -> void:
	rich_text.clear()
	for i in texto.length():
		if not escribiendo:
			# Si se interrumpe (por clic), salir
			return
		rich_text.append_text(texto[i])
		await get_tree().create_timer(0.03).timeout  # velocidad de escritura
