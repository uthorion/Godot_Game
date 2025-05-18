extends StaticBody2D

@onready var area = $Area2D



var dialogos_npc_01 = [
	"Finalmente has llegado.",
	"Creo que deberias pensar bien tus proximas elecciones."
]

func _ready():
	area.input_event.connect(_on_area_input)

func _on_area_input(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("🟨 Clic detectado")
		GESTORDIALOGOS.mostrar_dialogo_externo(dialogos_npc_01)


func _on_area_2d_mouse_entered():
	CURSORMANAGER.set_cursor_boca()


func _on_area_2d_mouse_exited():
	CURSORMANAGER.set_cursor_default()
