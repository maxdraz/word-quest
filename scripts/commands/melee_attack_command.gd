class_name MeleeAttackCommand
extends Command


func execute(target: Character, character: Character, state_machine: StateMachine) -> void:
	if !target or !character or !state_machine : return
	state_machine.clear_queue()
	var start_pos := character.global_position

	# queue rotate state
	# queue move state
	# queue attack state
	# queue idle state (duration)
	# queue move state
	pass
