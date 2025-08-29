extends "res://Scrips/Helpers/map_base.gd"

@onready var btn_map1 := $VBoxContainer/MapA
@onready var btn_map2 := $VBoxContainer/MapB
@onready var btn_map3 := $VBoxContainer/MapC

func _ready() -> void:
	handle_fade()
	btn_map1.pressed.connect(_on_map1_pressed)
	btn_map2.pressed.connect(_on_map2_pressed)
	btn_map3.pressed.connect(_on_map3_pressed)

func _on_map1_pressed() -> void:
	_go_to_map("res://Scenes/Maps/map_3.tscn")

func _on_map2_pressed() -> void:
	_go_to_map("res://Scenes/Maps/map_1.tscn")

func _on_map3_pressed() -> void:
	_go_to_map("res://Scenes/Maps/map_1.tscn")

func _go_to_map(path: String) -> void:
	GAMESTATE.previous_scene = get_scene_file_path() 
	get_tree().change_scene_to_file(path)
