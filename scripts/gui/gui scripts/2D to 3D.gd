extends Node3D

@onready var display = $display
@onready var viewport = $viewport
@onready var area = $area

var mesh_size = Vector2()

var mouse_entered = false
var mouse_held = false
var mouse_inside = false

var last_mouse_pos_3D = null
var last_mouse_pos_2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	area.mouse_entered.connect(_on_area_mouse_entered)
	area.mouse_exited.connect(_on_area_mouse_exited)
	viewport.set_process_input(true)
	viewport.transparent_bg=true
	display.material_override.flags_transparent=true

func _on_area_mouse_entered():
	mouse_entered = true

func _on_area_mouse_exited():
	mouse_entered = false
	mouse_inside = false  # Ensure mouse_inside is reset when the mouse exits the area

func _unhandled_input(event):
	if event is InputEventMouse:
		if mouse_entered or mouse_held:
			handle_mouse(event)
		else:
			viewport.push_input(event, true)
	else:
		viewport.push_input(event, true)

func handle_mouse(event):
	mesh_size = display.mesh.size

	if event is InputEventMouseButton or event is InputEventScreenTouch:
		mouse_held = event.pressed

	var mouse_pos3D = find_mouse(event.global_position)

	mouse_inside = mouse_pos3D != null

	if mouse_inside:
		mouse_pos3D = area.global_transform.affine_inverse() * mouse_pos3D
		last_mouse_pos_3D = mouse_pos3D
	else:
		mouse_pos3D = last_mouse_pos_3D if last_mouse_pos_3D != null else Vector3.ZERO

	var mouse_pos2D = Vector2(mouse_pos3D.x, -mouse_pos3D.y)

	# Convert from -meshsize/2 to meshsize/2
	mouse_pos2D.x += mesh_size.x / 2
	mouse_pos2D.y += mesh_size.y / 2
	# Convert to 0 to 1
	mouse_pos2D.x /= mesh_size.x
	mouse_pos2D.y /= mesh_size.y
	# Convert to viewport range 0 to viewport size
	mouse_pos2D.x *= viewport.size.x
	mouse_pos2D.y *= viewport.size.y

	event.position = mouse_pos2D
	event.global_position = mouse_pos2D

	if event is InputEventMouseMotion:
		event.relative = mouse_pos2D - (last_mouse_pos_2D if last_mouse_pos_2D != null else mouse_pos2D)

	last_mouse_pos_2D = mouse_pos2D

	viewport.push_input(event)

func find_mouse(pos: Vector2):
	var camera = get_viewport().get_camera_3d()
	var dss: PhysicsDirectSpaceState3D = get_world_3d().direct_space_state

	var rayparam = PhysicsRayQueryParameters3D.new()
	rayparam.from = camera.project_ray_origin(pos)
	rayparam.to = rayparam.from + camera.project_ray_normal(pos) * 1000  # Increased ray length
	rayparam.collide_with_bodies = false
	rayparam.collide_with_areas = true

	var result = dss.intersect_ray(rayparam)
	if result.size() > 0:
		return result.position
	else:
		return null
