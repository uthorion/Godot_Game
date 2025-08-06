extends "res://Scrips/Helpers/map_base.gd"

@export var next_scene_path: String = "res://Scenes/Maps/map_3.tscn"

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		await SCREENFADER.fade_out(0.5)
		get_tree().change_scene_to_file(next_scene_path)
		
func _on_area_2d_mouse_entered():
	CURSORMANAGER.set_cursor_mano()

func _on_area_2d_mouse_exited():
	CURSORMANAGER.set_cursor_default()
