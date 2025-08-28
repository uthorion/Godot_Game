extends "res://Scrips/Helpers/map_base.gd"

@onready var secretArea := $Pickup

func setup_player():
	move_player_to_entry_point()

func _ready():
	super()
	setup_player()

	if GAMESTATE.note_was_read:
		secretArea.visible = true
		secretArea.set_deferred("monitoring", true)
		secretArea.set_deferred("monitorable", true)
		
	else:
		secretArea.visible = false
		secretArea.monitoring = false
		secretArea.monitorable = false
