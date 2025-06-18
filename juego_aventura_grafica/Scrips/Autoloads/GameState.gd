extends Node
const SAVE_PATH := "user://save_data.json"

var previous_scene: String = ""

#guarda los IDs de los items recolectados por player
var collected_items: Array[Dictionary] = []
#guarda IDs de items tipo cofre que fueron abiertos
var opened_chests: Array[Dictionary] = []

func has_item(item_id: int) -> bool:
	for item in collected_items:
		if item.get("id") == item_id:
			return true
	return false

func has_opened(chest_id: int) -> bool:
	for chest in opened_chests:
		if chest.get("id") == chest_id:
			return true
	return false

func mark_item_collected(item_id: int, tipo: String = "llave"):
	if not has_item(item_id):
		collected_items.append({
			"id": item_id,
			"tipo": tipo
		})
#marca un cofre como abierto solo si no esta en la lista opened_chests
func mark_chest_opened(chest_id: int, tipo: String = "cofre"):
	if not has_opened(chest_id):
		opened_chests.append({
			"id": chest_id,
			"tipo": tipo
		})
		
func save_game():
	var save_data = {
		"collected_items": collected_items,
		"opened_chests": opened_chests
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_data))
	file.close()
	print("item", collected_items)
	print("item", opened_chests)
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

	var raw_items = parsed.get("collected_items", [])
	collected_items = []
	for item in raw_items:
		if typeof(item) == TYPE_DICTIONARY:
			collected_items.append(item)

	var raw_chests = parsed.get("opened_chests", [])
	opened_chests = []
	for chest in raw_chests:
		if typeof(chest) == TYPE_DICTIONARY:
			opened_chests.append(chest)

	print("Juego cargado.")
