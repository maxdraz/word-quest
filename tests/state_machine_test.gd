extends Node3D

@export var character : Character
@export var target : Character
@export var mouse_event_detector : MouseEventDetector

func _ready() -> void:
	mouse_event_detector.world_click.connect(on_world_click)
	character.init()


func on_world_click(result: Dictionary, button_index: int) -> void:
	
	if button_index == MOUSE_BUTTON_RIGHT:
		var click_pos = result.position
		var look_dir = -1 * character.position.direction_to(click_pos)
		look_dir.y = character.global_position.y
		var rotate_to_command = RotateToCommand.new()
		var params = RotateToStateParams.new()
		params.to_rotate = character
		params.look_dir = look_dir
		params.duration = 0.5
		rotate_to_command.execute(character.state_machine, params)
	elif button_index == MOUSE_BUTTON_MIDDLE:
		var click_pos = result.position
		var move_to_command = MoveToCommand.new()
		var params = MoveToStateParams.new()
		params.character = character
		params.target_position = click_pos
		params.rotation_duration = 0.2
		params.move_duration = 0.5
		move_to_command.execute(character.state_machine, params)		
	elif button_index == MOUSE_BUTTON_LEFT:
		var attack_command := MeleeAttackCommand.new()
		var params := AttackStateParams.new()
		params.attacker = character
		params.target = target
		params.animation_parameter = "parameters/StateMachine/Attack/conditions/melee_1"
		attack_command.execute(character.state_machine, params)
		
