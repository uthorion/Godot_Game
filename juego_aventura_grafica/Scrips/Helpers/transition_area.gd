extends Area2D

@export var target_scene: String
var can_trigger: bool = false

func _ready():
	await get_tree().create_timer(2).timeout  # espera 0.2 segundos
	can_trigger = true

func _on_body_entered(body):
	if body.name == "Player" and can_trigger:
		can_trigger = false
		GAMESTATE.previous_scene = get_tree().current_scene.scene_file_path
		GAMESTATE.save_game()
		await SCREENFADER.fade_out(0.5)
		get_tree().change_scene_to_file(target_scene)

func _on_body_exited(body):
	if body.name == "Player":
		can_trigger = true 
