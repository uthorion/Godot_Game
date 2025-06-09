extends Node
const SAVE_PATH := "res://Persistence/save_data.json"

var previous_scene: String = ""

#guarda los IDs de los items recolectados por player
var collected_items: Array[String] = []
#guarda IDs de items tipo cofre que fueron abiertos
var opened_chests: Array[String] = []

func has_item(item_id: String) -> bool:
	return item_id in collected_items

func has_opened(chest_id: String) -> bool:
	return chest_id in opened_chests

func mark_item_collected(item_id: String):
	if not has_item(item_id):
		collected_items.append(item_id)
#marca un cofre como abierto solo si no esta en la lista opened_chests
func mark_chest_opened(chest_id: String):
	if not has_opened(chest_id):
		opened_chests.append(chest_id)
		
func save_game():
	var save_data = {
		"collected_items": collected_items,
		"opened_chests": opened_chests
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	print("Juego guardado.")

func load_game():
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

	collected_items = parsed.get("collected_items", [])
	opened_chests = parsed.get("opened_chests", [])

	print("Juego cargado.")
