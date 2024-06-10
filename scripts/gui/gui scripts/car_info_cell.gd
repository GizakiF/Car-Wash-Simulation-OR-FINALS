class_name CarInfoCell
extends Node

@onready var label_queue_number = $"HBoxContainer/Label queue_number"
@onready var label_2_car_name = $"HBoxContainer/Label2 car_name"

#func _ready():
	#label_queue_number.text = "#x"
	#label_2_car_name.text = "car_name"

func set_label_queue_number(value: String):
	if label_queue_number != null:
		label_queue_number.text = value

func set_label_2_car_name(value: String):
	if label_2_car_name != null:
		label_2_car_name.text = value
