extends Area2D

@export var letter: String = "A"
@export var texture: Texture2D
signal letter_clicked(letter: String)


func _ready() -> void:
	if texture:
		$Sprite2D.texture = texture
	print("LetterTile lista:", letter, " en nodo:", self.name)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		emit_signal("letter_clicked", letter, self)

func _on_mouse_entered():
	CURSORMANAGER.set_cursor_inspect()

func _on_mouse_exited():
	CURSORMANAGER.set_cursor_default()

func get_letter() -> String:
	return letter
