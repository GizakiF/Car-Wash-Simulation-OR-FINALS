extends Control

@onready var h_slider_car_count = $"VBoxContainer/HSlider car count"
@onready var label_car_count = $"VBoxContainer/Label car count"

func _ready():
	h_slider_car_count.max_value = 2500
	h_slider_car_count.value = GlobalOptions.car_count
	label_car_count.text = str(h_slider_car_count.value) + " car(s)"

func _on_h_slider_car_count_drag_ended(_value_changed):
	GlobalOptions.car_count = h_slider_car_count.value
	print(str(GlobalOptions.car_count) + " cars!")


func _on_h_slider_car_count_value_changed(value):
	label_car_count.text = str(value) + " car(s)"
