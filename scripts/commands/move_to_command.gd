class_name MoveToCommand
extends Command


func execute(state_machine: StateMachine, params: MoveToStateParams):
	state_machine.clear_queue()
	var move_to_state = MoveToState.new()
	move_to_state.init(params)
	state_machine.enqueue(move_to_state)
