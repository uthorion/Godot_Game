extends "res://Scrips/Helpers/map_base.gd"

const REQUIRED_ITEM_ID := 1

@export var Start_text = []

@export var next_scene_path: String = "res://Scenes/SpecialScenes/scene_selector.tscn"
@export var back_scene_path: String = "res://Scenes/Maps/map_1.tscn"

@onready var lock_sound = $Area2D/LockSound

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if INVENTORY.has_item(REQUIRED_ITEM_ID):
			_play_sound()
			GAMESTATE.set_previous_scene()
			await SCREENFADER.fade_out(2)
			get_tree().change_scene_to_file(next_scene_path)
			INVENTORY.items.remove_at(0)
		else:
			GESTORDIALOGOS.show_external_dialog(Start_text)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		GAMESTATE.set_previous_scene()
		await SCREENFADER.fade_out(0.5)
		get_tree().change_scene_to_file(back_scene_path)

func _on_area_2d_mouse_entered():
	CURSORMANAGER.set_cursor_mano()

func _on_area_2d_mouse_exited():
	CURSORMANAGER.set_cursor_default()
	
func _play_sound():
	if not lock_sound.playing:
		lock_sound.play()

func _stop_sound():
	if lock_sound.playing:
		lock_sound.stop()
