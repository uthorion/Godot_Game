#var inventario_objetos: Array[Item]
#
#func addObjeto(obj: Item):
	#if(obj!=null):
		#inventario_objetos.push_back(obj)
		#print("Item added: "+inventario_objetos.back().nombre)
extends Node

var inventario_objetos: Array[String] = []

func add_item(item_id: String) -> void:
	if not has_item(item_id):
		inventario_objetos.append(item_id)

func has_item(item_id: String) -> bool:
	return item_id in inventario_objetos

func remove_item(item_id: String) -> void:
	inventario_objetos.erase(item_id)
