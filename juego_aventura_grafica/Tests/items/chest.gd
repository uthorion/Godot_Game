extends Area2D

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		open_detailed_view()

func open_detailed_view():
	var detailed_scene = preload("res://Tests/zoomIn/ZoomIN.tscn").instantiate()
	get_tree().root.add_child(detailed_scene) # O agregalo a un nodo UI
