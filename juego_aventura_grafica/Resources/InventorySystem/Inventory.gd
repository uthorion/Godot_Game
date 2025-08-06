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

func is_item_here(item: ItemData) ->bool:
	return true
	
func item_size(): 
	return items.size()
