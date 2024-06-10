extends Car

func _ready():
	self.name = "Compact car 1"
	car_name = name #why two names? one for the scene node which auto concat to the name 1, 2, 3s etc when a duplicate is found
	print(car_name + ' instantiated!')
