extends Area2D

@export var barrier_path: NodePath
@export var sprite_path: NodePath
@onready var tween := create_tween()
var warning_text := [
	"Cuando terminas de cruzar la calle las luces pierden intensidad",
	"Lo que sea que dejo pasar, volvio a bloquear el camino"
	]

var triggered := false

func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	if triggered:
		return
	if body.is_in_group("player"):
		triggered = true
		GESTORDIALOGOS.dialog_completed_callback = Callable(self, "_on_dialog_finished")
		GESTORDIALOGOS.show_external_dialog(warning_text)

func _on_dialog_finished():
	var barrier = get_node(barrier_path)
	var sprite = get_node(sprite_path)
	if barrier:
		barrier.visible = true
		barrier.collision_layer = 1
		barrier.collision_mask = 1
	if sprite:
		# Modulate a gris oscuro (0.4 en todos los canales, 1 en alpha)
		tween = create_tween()
		tween.tween_property(sprite, "modulate", Color(0.4, 0.4, 0.4, 1.0), 1.0)
	GAMESTATE.note_was_read = false
