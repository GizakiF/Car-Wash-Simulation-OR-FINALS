extends Control


# Called when the node enters the scene tree for the first time.



func _ready():
	

	pass



	

	
func _on_check_button_toggled(toggled_on):
	
	if toggled_on:
		EventBus.calculate_equations.emit()
		var tween = create_tween()
		
		var equations = $equations
		var target_position = equations.position + Vector2(-580, 0)
		tween.set_trans(1)
		tween.set_ease(2)
		tween.set_speed_scale(1)
		var equations_envrironment = equations.get_node("env")
		
		
		tween.tween_property(equations, "position", target_position, 1.0)
		
	if !toggled_on:
		var tween = create_tween()
		var equations_node = get_node("equations")
		var equations = $equations
		var target_position = equations.position + Vector2(+580, 0)
		tween.set_trans(0)
		tween.set_ease(2)
		tween.set_speed_scale(3)
		
		tween.tween_property(equations, "position", target_position, 1.0)
		
	
	pass # Replace with function body.
