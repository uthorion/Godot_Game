extends Node

@onready var inv_ui = $UI

func _ready():
	var key_item = preload("res://Resources/Items/KeyChest.tres")

	var _Inventory = Inventory.new()
	_Inventory.add_item(key_item)

	inv_ui.update_slots(_Inventory)
	inv_ui.current_inventory = _Inventory
