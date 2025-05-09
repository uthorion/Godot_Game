extends CharacterBody2D

const SPEED = 400
var player_position: Vector2
#el operador := declara e infiere el tipo de dato, en este caso infiere que es un booleano 
var moving := false
var facing_right = true

func _ready():
	player_position = global_position

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		player_position = get_global_mouse_position()
		moving = true


func _physics_process(delta):
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
 
		
		
	
