extends Area2D

@export var target_scene: String
var can_trigger: bool = true  # Evita repetir la opción si no se ha salido

@onready var label = $Label

func _ready():
	label.visible = false

func _on_body_entered(body):
	if body.name == "Player" and can_trigger:
		label.visible = true
		show_choice()
		#print("Entró al área")

func _on_body_exited(body):
	if body.name == "Player":
		can_trigger = true  # Permite que vuelva a mostrar al reingresar
		label.visible = false

func show_choice():
	can_trigger = false
	var dialog = ConfirmationDialog.new()
	dialog.dialog_text = "¿Pasar de sala?"
	dialog.connect("confirmed", Callable(self, "_on_choice_yes"))
	dialog.connect("canceled", Callable(self, "_on_choice_no"))
	get_tree().root.add_child(dialog)
	dialog.popup_centered()

func _on_choice_yes():
	GAMESTATE.previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(target_scene)

func _on_choice_no():
	print("No se cambió de escena.")
