extends StaticBody2D
	
const CURSOR_LUPA = preload("res://UI/Cursor/lupa.png")

@export var dialog_control: Node
@onready var area = $Area2D

var dialogo_lampara = [
	"Hola, soy una lámpara.",
	"Tengo una bombilla nueva y todo."
]

func _ready():
	pass
	
func _on_area_2d_mouse_entered():
	Input.set_custom_mouse_cursor(CURSOR_LUPA)

func _on_area_2d_mouse_exited():
	Input.set_custom_mouse_cursor(null)


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if dialog_control:
			dialog_control.mostrar_dialogo_externo(dialogo_lampara)
