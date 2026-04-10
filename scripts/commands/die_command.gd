class_name DieCommand
extends Command


func execute(state_machine: StateMachine, character: Character) -> void:
    state_machine.clear_queue()
    var state = DieState.new()
    state.init(character)
    state_machine.enqueue(state)