extends Node3D

@onready var car_wash_time = $"car wash time"
@onready var area_3d_head := $"Area3D head"
@onready var area_3d_car_inside_checker = $"Area3D car inside check"
@onready var area_3d_car_inside_stopper = $"Area3D car inside stopper"
@onready var animation_player = $AnimationPlayer
@onready var gpu_particles_water = $"water particles/GPU particles water"

#@export var text_mesh_timer: MeshInstance3D
var car: Car

func _ready():
	area_3d_head.collision_layer = 1
	area_3d_head.collision_mask = 10
	
	area_3d_car_inside_checker.collision_layer = 32
	area_3d_car_inside_checker.collision_mask = 10
	
	area_3d_car_inside_stopper.collision_layer = 10
	area_3d_car_inside_stopper.collision_mask = 10
	
	GlobalOptions.car_wash_second = float(60.0 / GlobalOptions.car_wash_per_minute)
	car_wash_time.wait_time = GlobalOptions.car_wash_second
	car_wash_time.start()
	car_wash_time.paused = true

func _process(_delta):
	GlobalOptions.car_wash_second = car_wash_time.time_left

func _on_area_3d_car_inside_check_area_entered(area):
	"""car is inside the car wash"""
	if area.get_parent_node_3d() is Car:
		area_3d_car_inside_checker.collision_layer = 32
		area_3d_car_inside_checker.collision_mask = 32
	
		car = area.get_parent_node_3d() as Car
		#print("The ", car.name, " is inside the car wash!")
		
		car.is_driving = false  # Stop the car????????????????
		car.speed = 0 #amu lng ni gali
		
		#car.update_collision_layer(32)
		
		car_wash_time.start()
		car_wash_time.paused = false
		gpu_particles_water.emitting = true
		animation_player.play("close door")
		EventBus.car_inside_car_wash.emit()

func _on_car_wash_time_timeout():
	"""the car wash will finish its service when the timer reaches 0 and will
	restart again to its orig wait time. Making sure that the time will pause until next car will
	enter the car wash"""
	area_3d_car_inside_checker.collision_layer = 32
	area_3d_car_inside_checker.collision_mask = 10
	
	area_3d_car_inside_stopper.collision_layer = 32
	
	car.is_driving = true
	car.speed = car.DEFAULT_SPEED
	
	gpu_particles_water.emitting = false
	animation_player.play_backwards("close door", 2)

	GlobalOptions.car_wash_second = car_wash_time.wait_time
	car_wash_time.start()
	car_wash_time.paused = true
	EventBus.car_cleaning_done.emit()
