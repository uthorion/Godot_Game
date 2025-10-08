extends Area2D

@export var require_player_inside := true

var _player_inside := false

func _ready() -> void:
	input_event.connect(_on_input_event)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		_player_inside = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		_player_inside = false

func _on_input_event(_vp, event, _shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if not require_player_inside or _player_inside:
			GAMESTATE.set_previous_scene()
			#GAMESTATE.capture_current_scene_state(get_tree().current_scene)
			GAMESTATE.save_game()
			print("Guardado en checkpoint:", GAMESTATE.previous_scene)
