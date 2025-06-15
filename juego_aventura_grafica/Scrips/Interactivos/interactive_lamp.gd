extends StaticBody2D

@onready var area = $Area2D

func _on_area_2d_mouse_entered():
	CURSORMANAGER.set_cursor_inspect()

func _on_area_2d_mouse_exited():
	CURSORMANAGER.set_cursor_default()

var dialogs_lamp = [
	"Hola, soy una lámpara.",
	"Tengo una bombilla nueva y todo.", 
	"Bienvenido a Pepe's company."
]

func _ready():
	area.input_event.connect(_on_area_input)

func _on_area_input(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("🟨 Clic detectado")
		GESTORDIALOGOS.show_external_dialog(dialogs_lamp)
