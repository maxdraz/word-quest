class_name RotateToCommand
extends Command


func execute(state_machine: StateMachine, params: RotateToStateParams):    
	state_machine.clear_queue()
	var rotate_to_state = RotateToState.new()
	rotate_to_state.init(params)
	state_machine.enqueue(rotate_to_state)
