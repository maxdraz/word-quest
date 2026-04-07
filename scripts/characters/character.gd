class_name Character
extends Node3D


enum FightingStyle 
{
	MELEE_1H = 0, 
	RANGED_BOW = 1, 
}

@export var animation_tree : AnimationTree
@export var fighting_style : FightingStyle
var animation_state_machine : AnimationNodeStateMachinePlayback
var state_machine := StateMachine.new()
signal animation_finished


func init() -> void:
	animation_state_machine = animation_tree.get("parameters/playback") 
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


func _animation_finished() -> void:
	animation_finished.emit()
