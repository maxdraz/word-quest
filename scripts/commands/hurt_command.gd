class_name HurtCommand
extends Command


func execute(state_machine: StateMachine, params:HurtStateParams) -> void:
    state_machine.clear_queue()
    var hurt_state = HurtState.new()
    hurt_state.init(params)
    state_machine.enqueue(hurt_state)