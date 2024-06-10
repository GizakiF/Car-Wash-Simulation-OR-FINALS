extends Control

@onready var pause_icon = $"pause icon"
@onready var play_icon = $"play icon"
@onready var h_slider = $"../VBoxContainer/HSlider"

var is_paused: bool = false

func _shortcut_input(event):
	if event.is_action_released("pause"):
		_on_pressed()


func _on_pressed():
	if !is_paused:
		pause_icon.visible = false
		play_icon.visible = true
		#get_tree().paused = true
		Engine.time_scale = 0
		h_slider.editable= false
	else:
		pause_icon.visible = true
		play_icon.visible = false
		#get_tree().paused = false
		Engine.time_scale = h_slider.value
		h_slider.editable= true
	is_paused = !is_paused

