extends Area2D

var note_text = [
	"Encuentras una nota en el suelo con unos escritos que dice:",
	"\"Aquellos que desean pasar deben dejar algo atras, solo entonces la señal cambiara. Una vez que se cruza el sendero ya no existe vuelta atras.\"",
	"Sientes un escalofrio que recorre tu cuerpo..."
]
var dialog_active := false

func _ready():
	input_event.connect(_on_note_clicked)

func _on_note_clicked(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GESTORDIALOGOS.dialog_completed_callback = Callable(self, "_on_dialog_finished")
		GESTORDIALOGOS.show_external_dialog(note_text)

func _on_dialog_finished():
	GAMESTATE.note_was_read = true
	queue_free()

func _on_mouse_entered():
	CURSORMANAGER.set_cursor_inspect()

func _on_mouse_exited():
	CURSORMANAGER.set_cursor_default()
