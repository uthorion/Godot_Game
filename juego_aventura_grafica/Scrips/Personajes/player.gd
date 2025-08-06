extends CharacterBody2D

@onready var agent = $NavigationAgent2D
@onready var sprite = $AnimatedSprite2D

const SPEED = 400
var facing_right = true

func _input(event):

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var target = get_global_mouse_position()
		agent.set_target_position(target)

func _physics_process(_delta):
	if GESTORDIALOGOS.active_dialog:
		velocity = Vector2.ZERO
		sprite.play("idle")
		return

	if agent.is_navigation_finished():
		velocity = Vector2.ZERO
		sprite.play("idle")
	else:
		var next_position = agent.get_next_path_position()
		var direction = (next_position - global_position).normalized()
		velocity = direction * SPEED

		# Animación y flip
		if direction.x != 0:
			facing_right = direction.x > 0
			sprite.flip_h = not facing_right

		sprite.play("walk")

	move_and_slide()
		
	
