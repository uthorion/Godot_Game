extends Area2D

@export var item_id: int = 1
@export var tipo: String = "llave"
@export var pickup_distance: float = 200.0

var dialogs_key_01 = [
	"Llave recolectada."
]

var is_pending_pickup := false
var player: Node2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if GAMESTATE.has_item(item_id):
		queue_free()
	GAMESTATE.mark_item_collected(item_id)

func _on_mouse_entered():
	CURSORMANAGER.set_cursor_mano()

func _on_mouse_exited():
	CURSORMANAGER.set_cursor_default()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if player == null:
			print("No hay jugador asignado")
			return
		var distance = global_position.distance_to(player.global_position)
		print("Distancia al jugador:", distance)
		if distance <= pickup_distance:
			if not INVENTORY.has_item(item_id):
				INVENTORY.add_item(item_id)
				print("Recolectado:", item_id)
			queue_free()
			GESTORDIALOGOS.show_external_dialog(dialogs_key_01)
			
		else:
			print("Jugador está demasiado lejos para recoger la llave")
