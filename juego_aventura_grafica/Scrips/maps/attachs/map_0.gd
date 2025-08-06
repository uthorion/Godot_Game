extends "res://Scrips/Helpers/map_base.gd"

var Start_text = [
	"Despiertas de golpe me medio de una plaza, sientes que algo no va bien",
	"Te tocas el cuerpo y pientas para tu adentro \"¿no estaba en el auto?\"",
	"Te estremeces pero decides que lo mas sensato es buscar algun lugar que te resulte conocido, por lo que empiezas a caminar."
]

func setup_player():
	move_player_to_entry_point()
