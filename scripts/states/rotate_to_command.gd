class_name RotateToCommand
extends Command

func execute(state_machine: StateMachine, to_rotate: Node3D, look_dir: Vector3):    
	state_machine.clear_queue()
	var rotate_to_state = RotateToState.new()
	rotate_to_state.init(to_rotate, look_dir)
	state_machine.enqueue(rotate_to_state)
