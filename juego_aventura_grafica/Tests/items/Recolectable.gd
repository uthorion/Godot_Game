extends Area2D

@export var ItemResource : ItemData
@onready var sprite = $Sprite2D

func _ready():
	input_event.connect(_on_input_event)
	if ItemResource!=null:
		sprite.texture=ItemResource.icon

func _on_input_event(viewport, event, shape_idx):
	print("entro a input event")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		INVENTORY.add_item(ItemResource)
