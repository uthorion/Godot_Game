extends Area2D

@export var barrier_path: NodePath
@export var blockmov_path: NodePath

var text_locked := ["Aprietas el boton pero el semaforo sigue en rojo"]
var text_locked_after_reading := ["Vuelves a apretar el boton, esta vez sientes que pierdes un gran peso"]
var text_unlocked := ["El semaforo se ha puesto en verde"]

func _ready():
	input_event.connect(_on_button_clicked)
	
func _on_button_clicked(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if GAMESTATE.note_was_read:
			GESTORDIALOGOS.dialog_completed_callback = Callable(self, "_on_unlock_path")
			GESTORDIALOGOS.show_external_dialog(text_unlocked)
		else:
			GESTORDIALOGOS.show_external_dialog(text_locked)

func _on_unlock_path():
	var barrier = get_node(barrier_path)
	var blockmov = get_node(blockmov_path)
	if barrier:
		barrier.set_deferred("visible", false)
		barrier.set_deferred("collision_layer", 0)
		barrier.set_deferred("collision_mask", 0)
	if blockmov:
		blockmov.queue_free()
	queue_free()

func _on_mouse_entered():
	CURSORMANAGER.set_cursor_inspect()

func _on_mouse_exited():
	CURSORMANAGER.set_cursor_default()
