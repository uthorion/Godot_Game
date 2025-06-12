extends Control

@onready var dialog_box = $Dialogo
@onready var rich_text = $Dialogo/MarginContainer/Dialogos
@onready var opciones_container = $Dialogo/MarginContainer/Opciones 

var dialogos = []
var current_dialog_index = 0
var escribiendo = false
var texto_completo = ""
var dialogo_activo := false

func _ready():
	visible = false
	dialog_box.visible = false
	opciones_container.visible = false

func mostrar_dialogo_externo(nuevos_dialogos: Array):
	dialogo_activo = true
	if nuevos_dialogos.is_empty():
		return

	dialogos = nuevos_dialogos.duplicate()
	current_dialog_index = 0
	visible = true
	dialog_box.visible = true
	opciones_container.visible = false
	rich_text.clear()
	mostrar_dialogo()

func mostrar_dialogo():
	if current_dialog_index >= dialogos.size():
		finalizar_dialogo()
		return

	var dialogo_actual = dialogos[current_dialog_index]

	if typeof(dialogo_actual) == TYPE_STRING:
		# Es diálogo normal
		opciones_container.visible = false
		texto_completo = dialogo_actual
		current_dialog_index += 1
		escribir_texto(texto_completo)

	elif typeof(dialogo_actual) == TYPE_DICTIONARY:
		# Es diálogo con opciones
		opciones_container.visible = true
		rich_text.clear()
		texto_completo = dialogo_actual.get("texto", "")
		escribiendo = false
		rich_text.text = texto_completo
		mostrar_opciones(dialogo_actual.get("opciones", []))

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
		elif not opciones_container.visible:
			mostrar_dialogo()

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if escribiendo:
			rich_text.text = texto_completo
			escribiendo = false
		elif not opciones_container.visible:
			mostrar_dialogo()

func mostrar_opciones(opciones: Array) -> void:
	# Limpiar botones anteriores
	for child in opciones_container.get_children():
		opciones_container.remove_child(child)
		child.queue_free()

	for i in range(opciones.size()):
		var opcion = opciones[i]
		var btn = Button.new()
		btn.text = opcion.get("texto", "Opción "+str(i))
		btn.add_theme_color_override("font_color", Color.WHITE)
		btn.add_theme_color_override("bg_color", Color.DARK_GRAY)
		btn.connect("pressed", Callable(self, "_on_opcion_seleccionada").bind(i))
		opciones_container.add_child(btn)

func _on_opcion_seleccionada(indice_opcion):
	var dialogo_actual = dialogos[current_dialog_index]
	var opciones = dialogo_actual.get("opciones", [])
	if indice_opcion < opciones.size():
		var siguiente = opciones[indice_opcion].get("siguiente", -1)
		if siguiente == -1:
			finalizar_dialogo()
		else:
			current_dialog_index = siguiente
			opciones_container.visible = false
			mostrar_dialogo()

func finalizar_dialogo():
	dialogo_activo = false
	dialog_box.visible = false
	opciones_container.visible = false
	visible = false
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.ignorar_input_un_frame = true
