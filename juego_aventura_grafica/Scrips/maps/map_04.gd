extends Node2D

func _ready():
	if GAMESTATE.previous_scene == "res://Scenes/SpecialScenes/map_wardrobe.tscn":
		SCREENFADER.fade_in(0.5)
		GAMESTATE.previous_scene = ""
	  
