extends Node

var car_arrival_rate_seconds: float
var car_wash_service_rate: float
var car_wash_per_minute: int
var car_count: int
var car_wash_second: float

func _init():
	car_arrival_rate_seconds = 30
	car_count = 20
	car_wash_per_minute = 3
