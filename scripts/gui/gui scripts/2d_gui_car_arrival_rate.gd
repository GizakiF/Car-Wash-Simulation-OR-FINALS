extends Control

@onready var h_slider = $VBoxContainer/HSlider
@onready var label_x_second_s_ = $"VBoxContainer/HBoxContainer/Label x second(s)"

func _ready():
	h_slider.value = GlobalOptions.car_arrival_rate_seconds
	label_x_second_s_.text = str(GlobalOptions.car_arrival_rate_seconds) + " second(s)"
	
func _on_h_slider_drag_ended(_value_changed):
	GlobalOptions.car_arrival_rate_seconds = h_slider.value
	print("1 car / " + str(GlobalOptions.car_arrival_rate_seconds) + " seconds")


func _on_h_slider_value_changed(value):
	label_x_second_s_.text = str(value) + " second(s)"
