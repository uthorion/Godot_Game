extends Node2D

@export var ItemResource : ItemData
@onready var sprite = $Sprite2D
@onready var area = $Area2D

func _ready():
	area.input_event.connect(_on_area_input_event)
	if ItemResource!=null:
		sprite.texture=ItemResource.icon

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and ItemResource!=null:
		INVENTORY.add_item(ItemResource)
		queue_free()
		CURSORMANAGER.set_cursor_default()

func _on_area_2d_mouse_entered():
	CURSORMANAGER.set_cursor_inspect()

func _on_area_2d_mouse_exited():
	CURSORMANAGER.set_cursor_default()
