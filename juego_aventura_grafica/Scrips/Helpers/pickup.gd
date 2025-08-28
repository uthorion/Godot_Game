extends Area2D

@export var ItemResource : ItemData
@export var isPlayerRequired: bool=false
@export var startHidden: bool = false # test

@onready var sprite = $Sprite2D
@onready var shape: CollisionShape2D = $CollisionShape2D

var canGrab: bool

func _ready():
	if ItemResource != null and INVENTORY.is_collected(ItemResource.id):
		queue_free()
		return
		
	input_event.connect(_on_area_input_event)
	
	if ItemResource != null:
		sprite.texture = ItemResource.icon
	canGrab = not isPlayerRequired
	
	sprite.visible = not startHidden
	shape.disabled = false
	

func _on_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if ItemResource != null and canGrab:
			INVENTORY.add_item(ItemResource)   
			queue_free()
			CURSORMANAGER.set_cursor_default()

func _on_mouse_entered():
	CURSORMANAGER.set_cursor_inspect()

func _on_mouse_exited():
	CURSORMANAGER.set_cursor_default()

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if isPlayerRequired:
		canGrab=true

func _on_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	if isPlayerRequired:
		canGrab=false
