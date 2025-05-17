extends Control

@onready var dialog_box = $Dialogo
@onready var rich_text = $Dialogo/MarginContainer/Dialogos

var dialogos = []
var current_dialog_index = 0
var escribiendo = false
var texto_completo = ""
var dialogo_activo := false

func _ready():
	visible = false
	dialog_box.visible = false

func mostrar_dialogo_externo(nuevos_dialogos: Array):
	dialogo_activo = true
	if nuevos_dialogos.is_empty():
		return

	dialogos = nuevos_dialogos.duplicate()
	current_dialog_index = 0
	visible = true
	dialog_box.visible = true
	rich_text.clear()
	mostrar_dialogo()

func mostrar_dialogo():
	if current_dialog_index < dialogos.size():
		texto_completo = dialogos[current_dialog_index]
		current_dialog_index += 1
		escribir_texto(texto_completo)
	else:
		dialogo_activo = false
		dialog_box.visible = false
		visible = false
		var player = get_tree().get_first_node_in_group("player")
		if player:
			player.ignorar_input_un_frame = true

func escribir_texto(texto):
	rich_text.clear()
	escribiendo = true
	await mostrar_texto_letra_por_letra(texto)
	escribiendo = false

func mostrar_texto_letra_por_letra(texto: String) -> void:
	for i in texto.length():
		if not escribiendo:
			return
		rich_text.append_text(texto[i])
		await get_tree().create_timer(0.03).timeout

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if escribiendo:
			rich_text.text = texto_completo
			escribiendo = false
		else:
			mostrar_dialogo()

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if escribiendo:
			rich_text.text = texto_completo
			escribiendo = false
		else:
			mostrar_dialogo()
