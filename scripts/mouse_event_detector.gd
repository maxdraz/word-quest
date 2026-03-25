class_name MouseEventDetector
extends Node3D

signal world_click(result: Dictionary, button_index: int)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var camera = get_viewport().get_camera_3d()
		var mouse_pos = event.position

		var origin = camera.project_ray_origin(mouse_pos)
		var direction = camera.project_ray_normal(mouse_pos)
		var end = origin + direction * 1000

		var query = PhysicsRayQueryParameters3D.create(origin, end)
		# Optional settings:
		# query.collide_with_areas = true
		# query.collide_with_bodies = true
		# query.exclude = [self]
		# query.collision_mask = 1

		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(query)

		if result:
			world_click.emit(result, event.button_index)
