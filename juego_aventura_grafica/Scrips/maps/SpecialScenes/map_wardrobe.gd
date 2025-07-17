extends Area2D

@onready var sprite = $Sprite2D

@export var next_scene_path: String = "res://Scenes/SpecialScenes/wardrobe.tscn"
@export var back_scene_path: String = "res://Scenes/Maps/map_04.tscn"
@export var sprite_open: Texture2D
@export var sprite_closed: Texture2D

var opened = false

func _ready():
	SCREENFADER.fade_in(0.5)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		opened = !opened
		sprite.texture = sprite_open if opened else sprite_closed

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		GAMESTATE.previous_scene = get_tree().current_scene.scene_file_path
		await SCREENFADER.fade_out(0.5)
		get_tree().change_scene_to_file(back_scene_path)

func _on_mouse_entered():
	CURSORMANAGER.set_cursor_inspect()

func _on_mouse_exited():
	CURSORMANAGER.set_cursor_default()
	
	
