extends PanelContainer

const SLOT_SCENE: PackedScene=preload("res://Scenes/inventory/slot.tscn")

@onready var h_box_container = $MarginContainer/HBoxContainer

func _ready():
	INVENTORY.items_chaged.connect(_on_inventory_chaged)
	INVENTORY.items_chaged.emit()

func _on_inventory_chaged():
	for i in h_box_container.get_child_count():
		h_box_container.get_child(i).queue_free()
	for i in INVENTORY.item_size():
		var slot=SLOT_SCENE.instantiate()
		h_box_container.add_child(slot)
		slot.setItem(INVENTORY.items[i])
