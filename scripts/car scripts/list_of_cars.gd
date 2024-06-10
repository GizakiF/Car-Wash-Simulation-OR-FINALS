extends Node

func get_all_cars() -> Array:
	var dir = DirAccess.open("res://objects/cars/")
	if dir == null:
		return []
	return dir.get_files()
