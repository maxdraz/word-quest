class_name RangedAttackCommand
extends Command

func execute(state_machine: StateMachine, params: AttackStateParams) -> void:
    if !params.target or !params.attacker or !state_machine : return
    var target_pos := params.target.global_position
    var destination := target_pos + target_pos.direction_to(params.attacker.global_position) * 3

    state_machine.clear_queue()
    # approach attacker
    var approach_target_state_params := MoveToStateParams.new()
    approach_target_state_params.character = params.attacker
    approach_target_state_params.target_position = destination
    approach_target_state_params.move_duration = 0.5
    approach_target_state_params.rotation_duration = 0.25
    var approach_target_state = MoveToState.new()
    approach_target_state.init(approach_target_state_params)
    state_machine.enqueue(approach_target_state)
    # attack
    var attack_state = AttackState.new()
    attack_state.init(params)
    state_machine.enqueue(attack_state)
    # return to start pos
    var return_to_original_pos_params := MoveToStateParams.new()
    return_to_original_pos_params.character = params.attacker
    return_to_original_pos_params.target_position = params.attacker.global_position	
    return_to_original_pos_params.move_duration = 0.5
    return_to_original_pos_params.rotation_duration = 0.25
    var return_to_original_pos_state = MoveToState.new()
    return_to_original_pos_state.init(return_to_original_pos_params)
    state_machine.enqueue(return_to_original_pos_state)
    # rotate to target
    var rotate_to_state_params = RotateToStateParams.new()
    rotate_to_state_params.to_rotate = params.attacker
    rotate_to_state_params.look_dir = -params.attacker.global_position.direction_to(target_pos)
    rotate_to_state_params.duration = 0.25
    var rotate_to_state = RotateToState.new()
    rotate_to_state.init(rotate_to_state_params)
    state_machine.enqueue(rotate_to_state)