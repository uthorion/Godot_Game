extends Control

@onready var dialog_box = $Dialogo
@onready var rich_text = $Dialogo/MarginContainer/Dialogos
@onready var options_container = $Dialogo/MarginContainer/Opciones 

var dialog = []
var current_dialog_index = 0
var writing = false
var complete_text = ""
var active_dialog := false

func _ready():
	visible = false
	dialog_box.visible = false
	options_container.visible = false

func show_external_dialog(new_dialogs: Array):
	active_dialog = true
	if new_dialogs.is_empty():
		return

	dialog = new_dialogs.duplicate()
	current_dialog_index = 0
	visible = true
	dialog_box.visible = true
	options_container.visible = false
	rich_text.clear()
	show_dialog()

func show_dialog():
	if current_dialog_index >= dialog.size():
		end_dialog()
		return

	var actual_dialog = dialog[current_dialog_index]

	if typeof(actual_dialog) == TYPE_STRING:
		# Es diálogo normal
		options_container.visible = false
		complete_text = actual_dialog
		current_dialog_index += 1
		writing_text(complete_text)

	elif typeof(actual_dialog) == TYPE_DICTIONARY:
		# Es diálogo con opciones
		options_container.visible = true
		rich_text.clear()
		complete_text = actual_dialog.get("texto", "")
		writing = false
		rich_text.text = complete_text
		show_options(actual_dialog.get("opciones", []))

func writing_text(texto):
	rich_text.clear()
	writing = true
	await show_text_letter_by_letter(texto)
	writing = false

func show_text_letter_by_letter(texto: String) -> void:
	for i in texto.length():
		if not writing:
			return
		rich_text.append_text(texto[i])
		await get_tree().create_timer(0.03).timeout

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if writing:
			rich_text.text = complete_text
			writing = false
		elif not options_container.visible:
			show_dialog()

func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		if writing:
			rich_text.text = complete_text
			writing = false
		elif not options_container.visible:
			show_dialog()

func show_options(opciones: Array) -> void:
	# Limpiar botones anteriores
	for child in options_container.get_children():
		options_container.remove_child(child)
		child.queue_free()

	for i in range(opciones.size()):
		var option = opciones[i]
		var btn = Button.new()
		btn.text = option.get("texto", "Opción "+str(i))
		btn.add_theme_color_override("font_color", Color.WHITE)
		btn.add_theme_color_override("bg_color", Color.DARK_GRAY)
		btn.connect("pressed", Callable(self, "_on_opcion_seleccionada").bind(i))
		options_container.add_child(btn)

func _on_selected_option(option_index):
	var actual_dialog = dialog[current_dialog_index]
	var options = actual_dialog.get("opciones", [])
	if option_index < options.size():
		var siguiente = options[option_index].get("siguiente", -1)
		if siguiente == -1:
			end_dialog()
		else:
			current_dialog_index = siguiente
			options_container.visible = false
			show_dialog()

func end_dialog():
	active_dialog = false
	dialog_box.visible = false
	options_container.visible = false
	visible = false
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.ignorar_input_un_frame = true
