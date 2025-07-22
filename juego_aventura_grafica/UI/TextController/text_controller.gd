extends Control

@onready var dialog_box = $Dialogo
@onready var rich_text = $Dialogo/MarginContainer/Dialogos
@onready var options_container = $Dialogo/MarginContainer/Opciones
@onready var background = $Dialogo/TextureRect

var external_text_target: RichTextLabel = null
var dialog = []
var current_dialog_index = 0
var writing = false
var complete_text = ""
var active_dialog := false
var dialog_completed_callback: Callable = Callable()

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
		complete_text = actual_dialog.get("text", "")
		writing = false
		rich_text.text = complete_text
		show_options(actual_dialog.get("options", []))

func set_external_text_target(label: RichTextLabel):
	external_text_target = label
	if external_text_target:
		background.visible = false
		dialog_box.visible = false  # Opcional: ocultar todo el box
	else:
		background.visible = true
		dialog_box.visible = true

func writing_text(text):
	if external_text_target:
		external_text_target.clear()
	else:
		rich_text.clear()

	writing = true
	await show_text_letter_by_letter(text)
	writing = false

func show_text_letter_by_letter(text: String) -> void:
	for i in text.length():
		if not writing:
			return
		if external_text_target:
			external_text_target.append_text(text[i])
		else:
			rich_text.append_text(text[i])
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

func show_options(options: Array) -> void:
	# Limpiar botones anteriores
	for child in options_container.get_children():
		options_container.remove_child(child)
		child.queue_free()

	for i in range(options.size()):
		var option = options[i]
		var btn = Button.new()
		btn.text = option.get("text", "option "+str(i))
		btn.add_theme_color_override("font_color", Color.WHITE)
		btn.add_theme_color_override("bg_color", Color.DARK_GRAY)
		btn.connect("pressed", Callable(self, "_on_selected_option").bind(i))
		options_container.add_child(btn)

func _on_selected_option(option_index):
	var actual_dialog = dialog[current_dialog_index]
	var options = actual_dialog.get("options", [])
	if option_index < options.size():
		var next = options[option_index].get("next", -1)
		if next == -1:
			end_dialog()
			if dialog_completed_callback.is_valid():
				dialog_completed_callback.call(option_index)
				dialog_completed_callback = Callable()
		else:
			current_dialog_index = next
			options_container.visible = false
			show_dialog()
			

func end_dialog():
	active_dialog = false
	dialog_box.visible = false
	options_container.visible = false
	visible = false

	if external_text_target:
		external_text_target.clear()
	external_text_target = null

	if dialog_completed_callback.is_valid():
		dialog_completed_callback.call()
		dialog_completed_callback = Callable()

	var player = get_tree().get_first_node_in_group("player")
