extends Node

@export var target_word: String = "AMOR"
var current_index: int = 0
var solved_tiles: Array = []

signal puzzle_completed(selected_letters: Array)

func _ready() -> void:
	print("PuzzleManager listo en:", self.name)
	for tile in get_tree().get_nodes_in_group("letter_tiles"):
		print("Tile encontrado:", tile.name)
		tile.connect("letter_clicked", Callable(self, "_on_letter_clicked"))

func _on_letter_clicked(letter: String, tile: Node) -> void:
	if letter.to_upper() == target_word[current_index].to_upper():
		current_index += 1
		solved_tiles.append(tile)  
		if current_index >= target_word.length():
			_on_puzzle_completed()

		if current_index >= target_word.length():
			_on_puzzle_completed()
	else:
		print("Incorrecto, reiniciando puzzle")
		current_index = 0
		solved_tiles.clear()

func _on_puzzle_completed() -> void:
	emit_signal("puzzle_completed", solved_tiles)
