extends Area2D

@export var mensaje: Array[String] = [
	"Algo bloquea tu paso"
]

var dialog_shown = false
var player = null

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if dialog_shown:
		return
	if body.is_in_group("player"):
		dialog_shown = true
		player = body
		
		# (Opcional) Detener movimiento momentáneamente para que vea el texto
		if "can_move" in player:
			player.can_move = false

		GESTORDIALOGOS.dialog_completed_callback = Callable(self, "_on_dialog_finished")
		GESTORDIALOGOS.show_external_dialog(mensaje)

func _on_dialog_finished():
	# (Opcional) Podés desbloquear el movimiento si querés
	# o dejarlo bloqueado si el jugador no debe moverse mientras no avance el juego.
	if player and "can_move" in player:
		player.can_move = true
