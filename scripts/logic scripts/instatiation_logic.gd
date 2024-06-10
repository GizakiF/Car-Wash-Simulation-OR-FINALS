extends Node3D

@onready var shape_cast_3d = $ShapeCast3D

func _process(_delta):
	if shape_cast_3d.is_colliding():
		self.position.z += -5
