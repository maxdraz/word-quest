extends Node3D

@export var character : Character
@export var mouse_event_detector : MouseEventDetector

func _ready() -> void:
	mouse_event_detector.world_click.connect(on_world_click)
	character.init()


func on_world_click(result: Dictionary) -> void:
	var click_pos = result.position
	var look_dir = -1 * character.position.direction_to(click_pos)
	var rotate_to_command = RotateToCommand.new()
	rotate_to_command.execute(character.state_machine, character, look_dir)
