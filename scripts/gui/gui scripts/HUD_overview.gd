extends Control

@export var cars_in_queue_node: Node
@export var car_in_service: Node
@export var cars_finished_queuing_node: Node


@onready var v_box_container_in_queue = $"HBoxContainer gui overview/ScrollContainer/VBoxContainer in queue"
@onready var v_box_container_in_service = $"HBoxContainer gui overview/ScrollContainer2/VBoxContainer in service"
@onready var v_box_container_served = $"HBoxContainer gui overview/ScrollContainer3/VBoxContainer served"

var car_info_cell: CarInfoCell

func _ready():
	EventBus.car_created.connect(in_queue)
	EventBus.car_moved_to_service.connect(in_service)
	EventBus.car_moved_to_served.connect(served)

func in_queue():
	if cars_in_queue_node.get_child_count() != 0:
		var car = cars_in_queue_node.get_child(-1) as Car
		var text: Label = Label.new()
		text.text = "#" + str(car.queue_number) + "\t  " + str(car.name)
		v_box_container_in_queue.add_child(text)

func in_service():
	if cars_in_queue_node.get_child_count() != 0:
		v_box_container_in_queue.get_child(0).reparent(v_box_container_in_service)

func served():
	if car_in_service.get_child_count() != 0:
		v_box_container_in_service.get_child(0).reparent(v_box_container_served)
