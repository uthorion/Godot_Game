extends CanvasLayer

@onready var fade = $ColorRect

func _ready():
	fade.visible = false
	fade.modulate.a = 0.0

func fade_out(duration := 0.5):
	fade.visible = true
	await create_tween().tween_property(fade, "modulate:a", 1.0, duration).finished

func fade_in(duration := 0.5):
	await create_tween().tween_property(fade, "modulate:a", 0.0, duration).finished
	fade.visible = false
