extends Node2D

@export var ItemResource : ItemData
@onready var sprite = $Sprite2D
@onready var area = $Area2D

func _ready():
	area.input_event.connect(_on_area_input_event)
	if ItemResource!=null:
		sprite.texture=ItemResource.icon

func _on_area_input_event(viewport, event, shape_idx):
	print("entro a input event")
	
