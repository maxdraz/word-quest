class_name Health
extends Node

@export var max_health := 100
@export var current : int
signal changed(previous: int, new: int, max: int)

func _ready():
	set_health(max_health)
	

func init(max_health: int) -> void:
	self.max_health = max_health
	current = max_health
	changed.emit(current, current, max_health)


func set_health(value: int, notify:= true) -> void:
	var previous = current
	current = value
	if notify:
		changed.emit(previous, current, max_health)


func add_health(value: int, notify:= true) -> void:
	set_health(current + value, notify)


func set_max_health(value: int, notify:= true) -> void:
	max_health = value
	if notify:
		changed.emit(current, current, max_health)
