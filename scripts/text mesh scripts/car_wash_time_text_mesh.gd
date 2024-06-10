extends Node


func _process(_delta):
	#print(GlobalOptions.car_wash_second, "second")
	if GlobalOptions.car_wash_second < 1:
		self.mesh.text = str(GlobalOptions.car_wash_second).substr(0,4)
	elif GlobalOptions.car_wash_second < 10: #ensures that only 1 decimal will be displayed when wait time is single digit(to make it pleasant to the eyes)
		self.mesh.text = str(GlobalOptions.car_wash_second).substr(0,3)
	else:
		self.mesh.text = str(GlobalOptions.car_wash_second).substr(0,4)
		
	
	

