extends Node

@export var instatiation_position: Marker3D
@export var cars_in_queue_node: Node
@export var car_in_service: Node
@export var cars_finished_array: Node

@onready var arrival_rate_seconds = $"arrival rate seconds"

const SCENE_MAX_CAR_COUNT = 9
var scene_car_count: int = 0

var cars_in_queue_array: Array
var queue_index: int = 0

func _ready():
	arrival_rate_seconds.wait_time = GlobalOptions.car_arrival_rate_seconds
	cars_in_queue_array.resize(GlobalOptions.car_count)
	EventBus.car_inside_car_wash.connect(move_car_in_service)
	EventBus.car_cleaning_done.connect(move_car_to_finished)
	store_random_cars()

func store_random_cars():
	var dir = DirAccess.open("res://objects/cars/")
	if not dir:
		print("Failed to open directory")
		return

	var list_of_cars: Array = dir.get_files()
	var rand = RandomNumberGenerator.new()

	for i in range(cars_in_queue_array.size()):
		var randI = rand.randi_range(0, list_of_cars.size() - 1)
		var file_path = "res://objects/cars/" + list_of_cars[randI]
		file_path = file_path.replace('.remap', '')
		if ResourceLoader.exists(file_path):
			cars_in_queue_array[i] = ResourceLoader.load(ProjectSettings.localize_path(file_path))
		else:
			print("File does not exist:", file_path)

	print(cars_in_queue_array)


func _process(_delta):
	pass

func check_cars_in_scene() -> void:
	"""checks if a car exceeds the max car count in scene value"""
	if scene_car_count == SCENE_MAX_CAR_COUNT:
		arrival_rate_seconds.paused = true
	else:
		arrival_rate_seconds.paused = false

func instantiate_car():
	if queue_index < cars_in_queue_array.size():
		var car = cars_in_queue_array[queue_index]
		var car_instance = car.instantiate() as Car
		car_instance.queue_number = queue_index + 1
		car_instance.add_to_group("cars")
		cars_in_queue_node.add_child(car_instance)
		car_instance.global_position = instatiation_position.global_position
		if cars_in_queue_node.get_child_count() == 1 and car_in_service.get_child_count() != 1:  # make the first instantiated child as the head
			make_first_child_as_head()
		queue_index += 1
		scene_car_count += 1
		
		EventBus.car_created.emit()
	else:
		arrival_rate_seconds.stop()
	#print("Child count of cars_in_queue_node(after initialization): ", cars_in_queue_node.get_child_count())

func _on_arrival_rate_per_minute_timeout():
	instantiate_car()

func make_first_child_as_head():
	if cars_in_queue_node.get_child_count() != 0:
		cars_in_queue_node.get_child(0).is_head = true
		#print('Head child: ', cars_in_queue_node.get_child(0), cars_in_queue_node.get_child(0).is_head)
		#print(cars_in_queue_node.get_child(0).is_head, "<- car")

func move_car_in_service():
	if cars_in_queue_node.get_child_count() != 0:
		var car = cars_in_queue_node.get_child(0) as Car
		#only heads should pass no more
		if car.is_head:
			EventBus.car_moved_to_service.emit()
			car.reparent(car_in_service)

func move_car_to_finished():
	if car_in_service.get_child_count() != 0:
		EventBus.car_moved_to_served.emit()		
		var car = car_in_service.get_child(0) as Car
		car.reparent(cars_finished_array)
		car.update_collision_layer(32)
		cars_finished_array.get_child(-1).is_head = false
		
	make_first_child_as_head()
	

