extends Node

@onready var h_slider = $HBoxContainer/VBoxContainer/HSlider
@onready var label_x_speed = $"HBoxContainer/VBoxContainer/HBoxContainer/Label x speed"



func _ready():
	h_slider.value = Engine.time_scale
	label_x_speed.text = "▶ " + "normal"
	#process_mode = Node.PROCESS_MODE_PAUSABLE

func _on_h_slider_value_changed(value):
	Engine.time_scale = value
	if int(Engine.time_scale) == 1:
		label_x_speed.text = "▶ " + "normal"
	else:
		label_x_speed.text = "▶▶ " + str(Engine.time_scale) + "x"

func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		_on_texture_button_pressed()

func _on_texture_button_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://scenes/simulation_world.tscn")


func _on_home_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
