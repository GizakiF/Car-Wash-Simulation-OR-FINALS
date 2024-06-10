class_name Car
extends Node3D

var queue_number: int
var service_time: float
var car_name: String
var destination
var exit_destination

var is_driving: bool = true
var is_head: bool = false 

const DEFAULT_SPEED: float = 5.0

@export var speed: float = 5.0
@export var rear_lights: Node3D
@export var box_shape_cast: ShapeCast3D
@export var box_collision_area_3D: Area3D


func _process(delta):
	if is_driving:
		check_front()
		drive_forward(delta)
	else:
		not_driving()
	#print(name, " head status: ", is_head)
	if !is_head and !box_shape_cast.is_colliding():
		is_driving = true
	#to make the head have diffrent collsion to pass through the head checker 
	#(head checker checks for layer 1. layer 1 are cars that are not head). 
	#The collision layer must be equal to that mask of the car inside checker to not pass through
	if is_head:
		is_driving = true
		box_collision_area_3D.collision_layer = 10

func check_front():
	if box_shape_cast.is_colliding() and !is_head:
		is_driving = false

func drive_forward(delta):
	rear_lights.visible = false
	self.translate(Vector3(0, 0, speed * delta))

func not_driving():
	is_driving = false
	rear_lights.visible = true

func update_collision_layer(new_layer: int):
	box_collision_area_3D.collision_layer = new_layer
