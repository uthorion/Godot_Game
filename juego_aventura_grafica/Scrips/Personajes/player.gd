extends CharacterBody2D

const SPEED = 250
var player_position: Vector2
var moving := false
var facing_right = true
var ignorar_input_un_frame := false

func _ready():
	player_position = global_position

func _input(event):
	if ignorar_input_un_frame:
		ignorar_input_un_frame = false
		return 

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var target = get_global_mouse_position()
		player_position = Vector2(target.x, global_position.y)
		moving = true

func _physics_process(_delta):
	if GESTORDIALOGOS.dialogo_activo:
		return
	if moving:
		var direction = (player_position - global_position).normalized()
		velocity = direction * SPEED
		if direction.x != 0:
			facing_right = direction.x > 0
			$AnimatedSprite2D.flip_h = not facing_right
		if global_position.distance_to(player_position) < 4:
			moving = false
			velocity = Vector2.ZERO
	else:
		velocity = Vector2.ZERO
	move_and_slide()
		
		
	
