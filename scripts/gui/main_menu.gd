extends Node3D

@onready var main_menu = $"."

@onready var start_sim_text_2 = $start_sim_area/start_sim_text2
@onready var main_menu_camera = $"main menu camera"
@onready var main_menu_animation_player = $"main menu camera/AnimationPlayer"
@onready var bg_dark = $"bg dark"

@onready var start_sim_area = $start_sim_area

#next buttons
@onready var next_to_car_arrival_rate = $"next to car arrival rate"
@onready var next_to_car_wash_time = $"next to car wash time"
@onready var next_to_simulation = $"next to simulation"

#back buttons
@onready var back_to_start = $"back to start"
@onready var back_to_car_count = $"back to car count"
@onready var back_to_car_arrival_rate = $"back to car arrival rate"

#3d GUIs
#@onready var _3d_gui_car_count = $"3D GUI car count"
#@onready var _3d_gui_car_arrival_rate = $"3D GUI car arrival rate"
@onready var _3d_gui_car_wash_time = $"3D GUI car wash time"

func _ready():
	Engine.time_scale = 1
	
	next_to_car_wash_time.visible = false
	next_to_simulation.visible = false
	
	back_to_start.visible = false
	back_to_car_count.visible = false
	back_to_car_arrival_rate.visible = false

	_3d_gui_car_wash_time.visible = false
	main_menu_camera.position = Vector3(-12.69, 0.297, 1.195)
	main_menu_camera.rotation_degrees = Vector3(8.2, -147.2, -1.2)
	bg_dark.visible = false


############################ START BUTTONS ###########################

func _on_start_sim_area_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_start_sim_area_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)	


func _on_start_sim_area_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			main_menu_animation_player.play("car_count_menu_animation")
			next_to_car_wash_time.visible = false
			back_to_start.visible = true
			
			var timer: Timer = Timer.new()
			timer.wait_time = 1
			timer.autostart = true
			timer.one_shot = true
			add_child(timer)
			timer.timeout.connect(func(): start_sim_area.visible = false)
			timer.timeout.connect(func():timer.queue_free())

func _on_next_to_car_arrival_rate_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_next_to_car_arrival_rate_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_next_to_car_arrival_rate_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			main_menu_animation_player.play("car_arrival_rate_menu_animation")
			next_to_car_wash_time.visible = true
			next_to_car_arrival_rate.hide()
			var timer: Timer = Timer.new()
			timer.wait_time = 1
			timer.autostart = true
			timer.one_shot = true
			add_child(timer)
			timer.timeout.connect(func(): back_to_car_count.visible = true)
			timer.timeout.connect(func():timer.queue_free())
			

func _on_next_to_car_wash_time_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_next_to_car_wash_time_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_next_to_car_wash_time_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			next_to_simulation.visible = true
			_3d_gui_car_wash_time.visible = true
			main_menu_animation_player.play("car_wash_time_menu_animation")
			bg_dark.visible = true
			back_to_car_arrival_rate.visible = true


func _on_next_to_simulation_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_next_to_simulation_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_next_to_simulation_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			print("USER OPTIONS:")
			print("car count: ", GlobalOptions.car_count)
			print("1 car arrival rate per ", GlobalOptions.car_arrival_rate_seconds, " second(s)")
			print(GlobalOptions.car_wash_per_minute, " car(s) per 1 minute")
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			get_tree().change_scene_to_file("res://scenes/simulation_world.tscn")


############################ BACK BUTTONS ###########################

func _on_back_to_start_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_back_to_start_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_back_to_start_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			main_menu_animation_player.play_backwards("car_count_menu_animation")
			start_sim_area.visible = true



func _on_back_to_car_count_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_back_to_car_count_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_back_to_car_count_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			main_menu_animation_player.play_backwards("car_arrival_rate_menu_animation")
			back_to_car_count.visible = false
			next_to_car_wash_time.visible = false
			var timer: Timer = Timer.new()
			timer.wait_time = 1
			timer.autostart = true
			timer.one_shot = true
			add_child(timer)
			timer.timeout.connect(func(): next_to_car_arrival_rate.visible = true)
			timer.timeout.connect(func():timer.queue_free())

func _on_back_to_car_arrival_rate_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_back_to_car_arrival_rate_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_back_to_car_arrival_rate_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			main_menu_animation_player.play_backwards("car_wash_time_menu_animation")
			bg_dark.visible = false
			_3d_gui_car_wash_time.visible = false
			next_to_simulation.visible = false
			back_to_car_arrival_rate.visible = false


func _on_exit_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_exit_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_exit_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			get_tree().quit()
