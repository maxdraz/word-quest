class_name Projectile
extends Node3D


@export var speed := 10.0
@export var offset_y := 1
var target: Node3D
signal finished


func init(start: Node3D, target: Node3D) -> void:
	self.target = target
	global_position = start.global_position + (Vector3.UP * offset_y)
	look_at(target.global_position + (Vector3.UP * offset_y))


func _process(delta: float) -> void:
	if !target: return
	global_position = global_position.move_toward(target.global_position + (Vector3.UP * offset_y), delta * speed)
	if global_position.distance_squared_to(target.global_position + (Vector3.UP * offset_y)) <= 0.125 * 0.125:
		finished.emit()
		queue_free()

