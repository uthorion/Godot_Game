extends CanvasLayer

@onready var toggle_button = $InventoryUI/Open_Close
@onready var slots_container = $InventoryUI/Slots_container

@export var sprite_close: Texture2D
@export var sprite_open: Texture2D

var open := false
var current_inventory: Inventory

func _ready():
	slots_container.visible = false

func _on_open_close_toggled(toggled_on):
	open = !open
	toggle_button.texture_normal = sprite_open if open else sprite_close
	slots_container.visible = open

func update_slots(inv: Inventory):
	current_inventory = inv
	for i in range(6):
		var button = slots_container.get_child(i)
		if i < inv.slots.size():
			button.texture_normal = inv.slots[i].item_data.icon
			button.visible = true
		else:
			button.texture_normal = null
			button.visible = false
