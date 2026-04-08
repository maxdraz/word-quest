class_name RangedAttackCommand
extends Command

func execute(state_machine: StateMachine, params: AttackStateParams) -> void:
    if !params.target or !params.attacker or !state_machine : return
    state_machine.clear_queue()
    # attack
    var attack_state = AttackState.new()
    attack_state.init(params)
    state_machine.enqueue(attack_state)