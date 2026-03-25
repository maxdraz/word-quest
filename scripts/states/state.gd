class_name State
extends RefCounted

signal exited(state: State)

func enter() -> void:
	pass


func process(delta) -> void:
	pass


func physics_process(delta) -> void:
	pass


func cancel() -> void:
	pass


func exit() -> void:
	exited.emit(self)
