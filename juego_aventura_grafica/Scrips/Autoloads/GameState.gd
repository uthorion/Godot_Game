extends Node
const SAVE_PATH := "user://save_data.json"

var previous_scene: String = ""
var coming_from_cinematic := false
var note_was_read := false

var opened_chests: Array[Dictionary] = []

func has_opened(chest_id: int) -> bool:
	for chest in opened_chests:
		if chest.get("id") == chest_id:
			return true
	return false

#marca un cofre como abierto solo si no esta en la lista opened_chests
func mark_chest_opened(chest_id: int, tipo: String = "cofre"):
	if not has_opened(chest_id):
		opened_chests.append({
			"id": chest_id,
			"tipo": tipo
		})

func set_previous_scene():
	previous_scene = get_tree().current_scene.scene_file_path

func save_game() -> void:
	var save_data = {
		#"inventory": Inventory.to_dict(),
		"opened_chests": opened_chests
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	print("Juego guardado.")

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No hay archivo de guardado.")
		return
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = file.get_as_text()
	file.close()

	var parsed = JSON.parse_string(data)
	if parsed == null:
		print("Error al leer archivo de guardado.")
		return

	#Inventory.from_dict(parsed.get("inventory", []))
	opened_chests = parsed.get("opened_chests", [])
	print("Juego cargado.")
