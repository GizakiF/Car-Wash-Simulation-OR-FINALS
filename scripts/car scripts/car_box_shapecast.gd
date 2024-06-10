extends ShapeCast3D
#
#signal car_ahead
#signal drive_ahead

#func _process(_delta):
	#if is_colliding() and !self.is_head:
		#car_ahead.emit()
	#else:
		#drive_ahead.emit()
