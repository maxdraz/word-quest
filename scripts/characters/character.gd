class_name Character
extends Node3D


@export var animation_player : AnimationPlayer
@export var animation_tree : AnimationTree
var state_machine := StateMachine.new()


func init() -> void:
	var idle_state = IdleState.new()
	var params = IdleStateParams.new()
	params.character = self
	idle_state.init(params)
	state_machine.init(idle_state)


func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)


func deal_damage():
	print("damage_dealt")
	pass
