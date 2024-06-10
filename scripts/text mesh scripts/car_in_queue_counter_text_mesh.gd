extends Node3D

@export var cars_in_queue: Node
@onready var mesh_x_count = $"mesh x count"

func _process(_delta):
	mesh_x_count.mesh.text = str(cars_in_queue.get_child_count())
