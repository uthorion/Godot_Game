extends Node
const SAVE_PATH := "user://save_data.json"

var previous_scene: String = ""

var note_was_read := false 
var collected_items: Array[String] = []  

func _ready():
	reset_session()

func reset_session() -> void:
	previous_scene = ""

func new_game() -> void:
	note_was_read = false
	collected_items.clear()
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)

func set_previous_scene() -> void:
	previous_scene = get_tree().current_scene.scene_file_path

func save_game() -> void:
	var data := {
		"note_was_read": note_was_read,
		"collected_items": collected_items,
		"previous_scene": previous_scene,
	}
	var f := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	f.store_string(JSON.stringify(data))
	f.close()
	print("Juego guardado en:", SAVE_PATH)

func load_game() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No hay archivo de guardado.")
		return false

	var f := FileAccess.open(SAVE_PATH, FileAccess.READ)
	var parsed: Variant = JSON.parse_string(f.get_as_text())
	f.close()

	if parsed == null or not (parsed is Dictionary):
		printerr("Error al leer el archivo de guardado.")
		return false

	var data: Dictionary = parsed

	note_was_read = data.get("note_was_read", false)

	collected_items.clear()
	for v in (data.get("collected_items", []) as Array):
		if typeof(v) == TYPE_STRING:
			collected_items.append(v)

	previous_scene = data.get("previous_scene", "")
	print("Juego cargado.")
	return true

func is_item_collected(uid: String) -> bool:
	return uid in collected_items

func mark_item_collected(uid: String) -> void:
	if uid not in collected_items:
		collected_items.append(uid)
