extends CanvasLayer

@onready var color_rect = $ColorRect

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

func toggle_pause():
	if get_tree().paused:
		get_tree().paused = false
		hide()
	else:
		get_tree().paused = true
		show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()
