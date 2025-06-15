extends StaticBody2D

#define que item requiere el cofre para abierse, el objeto debe estar en collected_items (el inventario)
@export var required_item_id: int = 1
@export var chest_id: int = 1
@export var tipo: String = "cofre"
@export var open_texture: Texture2D
var is_open := false

var dialogs_chest = [
	"necesitas la llave para el cofre",
	"has abierto el cofre"
]

func _ready():
	if GAMESTATE.has_opened(chest_id):
		is_open = true
		$Sprite2D.texture = open_texture

func _on_area_2d_mouse_entered():
	if is_open: 
		CURSORMANAGER.set_cursor_default()
	else: 
		CURSORMANAGER.set_cursor_llave()

func _on_area_2d_mouse_exited():
	CURSORMANAGER.set_cursor_default()

func open_chest():
	is_open = true
	GAMESTATE.mark_chest_opened(chest_id, tipo)
	$Sprite2D.texture = open_texture
	GESTORDIALOGOS.show_external_dialog([dialogs_chest[1]])

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if is_open:
			print("El cofre ya está abierto.")
			return

		if INVENTORY.has_item(required_item_id):
			open_chest()
		else:
			print("El cofre está cerrado. Necesitás la llave.")
			GESTORDIALOGOS.show_external_dialog([dialogs_chest[0]])
