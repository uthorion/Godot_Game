extends Node
class_name Inventory

var items: Array[ItemData] = []

signal items_chaged

func _ready():
	add_item(preload("res://Resources/Items/KeyChest.tres"))
	add_item(preload("res://Resources/Items/KeyChest.tres"))
	add_item(preload("res://Resources/Items/KeyChest.tres"))
	add_item(preload("res://Resources/Items/KeyChest.tres"))

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		add_item(preload("res://Resources/Items/KeyChest.tres"))

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
