extends Command


func execute(state_machine: StateMachine, target: Transform3D, look_dir: Vector3):
    state_machine.clear_queue()
    state_machine.enqueue(RotateToState