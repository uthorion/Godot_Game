extends Node

var inventory_objects: Array[int] = []

func add_item(item_id: int) -> void:
	if not has_item(item_id):
		inventory_objects.append(item_id)

func has_item(item_id: int) -> bool:
	return item_id in inventory_objects

func remove_item(item_id: int) -> void:
	inventory_objects.erase(item_id)
