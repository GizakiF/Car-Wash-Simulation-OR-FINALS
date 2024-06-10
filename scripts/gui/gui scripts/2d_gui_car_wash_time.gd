extends Control

@onready var label_x_second_s_ = $"VBoxContainer/Label x second(s)"
@onready var h_slider = $VBoxContainer/HSlider
@onready var line_edit = $VBoxContainer/LineEdit

func _ready():
	h_slider.value = GlobalOptions.car_wash_per_minute
	label_x_second_s_.text = str(GlobalOptions.car_wash_per_minute) + " car(s) per 1 minute"
	line_edit.placeholder_text = "tired of sliders? use this input block instead! " + str(GlobalOptions.car_wash_per_minute) + " seconds (default)"

func _on_h_slider_drag_ended(_value_changed):
	GlobalOptions.car_wash_per_minute = h_slider.value
	print("The car wash will wash " + str(GlobalOptions.car_wash_per_minute) + " per 1 minute!")

func _on_h_slider_value_changed(value):
	#line_edit.placeholder_text = str(value) + " second(s)"
	line_edit.clear()
	label_x_second_s_.text = str(value) + " car(s) per 1 minute"
	GlobalOptions.car_wash_per_minute = int(value)
