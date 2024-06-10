extends Node3D

@export var car_queueing_finished: Node

@onready var text_mesh_served_count = $"text mesh served count"
@onready var text_mesh_served = $"text mesh SERVED"

func _ready():
	text_mesh_served.mesh.text = "served".to_upper()

func _process(_delta):
	text_mesh_served_count.mesh.text = str(car_queueing_finished.get_child_count())
