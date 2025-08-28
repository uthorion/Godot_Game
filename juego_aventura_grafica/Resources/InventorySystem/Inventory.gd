extends Node
class_name Inventory

var items: Array[ItemData] = []

signal items_chaged

func add_item(item: ItemData):
	if items.size() >= 6:
		print("Inventario lleno")
		return
	items.append(item)
	items_chaged.emit()

func delete_item_by_reference(item: ItemData) -> bool:
	for i in range(items.size()):
		if items[i] == item:
			items.remove_at(i)
			items_chaged.emit()
			return true
	return false

func has_item(item_id: int) -> bool:
	for item in items:
		if item.get("id") == item_id:
			return true
	return false

func to_dict() -> Array:
	var save_array: Array = []
	for item in items:
		save_array.append({
			"id": item.id,
			"type": item.type,     # ← usa el campo de ItemData
			"icon": item.icon.resource_path if item.icon else ""
		})
	return save_array
	
func from_dict(data: Array) -> void:
	items.clear()
	for d in data:
		if typeof(d) == TYPE_DICTIONARY:
			var new_item := ItemData.new()
			new_item.id = d.get("id", -1)
			new_item.type = d.get("type", "")
			
			var icon_path: String = d.get("icon", "")
			if icon_path != "":
				new_item.icon = load(icon_path)
			
			items.append(new_item)
	
func item_size(): 
	return items.size()

func is_collected(item_id: int) -> bool:
	for item in items:
		if item.id == item_id:
			return true
	return false
