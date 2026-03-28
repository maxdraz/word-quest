class_name Character
extends CharacterBody3D


@export var animation_tree : AnimationTree
var state_machine : StateMachine


func init() -> void:
	state_machine = StateMachine.new()
	var idle_state = IdleState.new()
	var params = IdleStateParams.new()
	params.character = self
	idle_state.init(params)
	state_machine.init(idle_state)


func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
