extends Node

var inventario_objetos: Array[Item]

func addObjeto(obj: Item):
	if(obj!=null):
		inventario_objetos.push_back(obj)
		print("Item added: "+inventario_objetos.back().nombre)
