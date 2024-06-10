extends Node3D

@onready var text_mesh_car_arrives_in = $"text mesh car arrives in"
@onready var text_mesh_x_sec = $"text mesh x sec"
@export var car_manager: Node
var car_manager_timer: Timer


func _ready():
	car_manager_timer = car_manager.get_node("arrival rate seconds")

func _process(_delta):
	if car_manager_timer.is_stopped():
		text_mesh_x_sec.hide()
		#text_mesh_car_arrives_in.position.x += -2
		text_mesh_car_arrives_in.mesh.text = "no cars left".to_upper()
	else:
		text_mesh_car_arrives_in.mesh.text = "a car arrives in".to_upper()
		if car_manager_timer.time_left < 10: #ensures that only 1 decimal will be displayed when wait time is single digit(to make it pleasant to the eyes)
			text_mesh_x_sec.mesh.text = str(car_manager_timer.time_left).substr(0,3)
		else:
			text_mesh_x_sec.mesh.text = str(car_manager_timer.time_left).substr(0,4)
