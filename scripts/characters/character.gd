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


func look_at_target(target: Node3D, instant:= false) -> void:
	if instant:
		look_at(-target.position)
		return
	
	var look_dir = -position.direction_to(target.position)
	look_dir.y = global_position.y
	var rotate_to_command = RotateToCommand.new()
	var params = RotateToStateParams.new()
	params.to_rotate = self
	params.look_dir = look_dir
	params.duration = 0.5
	rotate_to_command.execute(state_machine, params)


func attack(target: Character) -> void:
	var attack_command
	match fighting_style:
		FightingStyle.MELEE_1H:
			attack_command = MeleeAttackCommand.new()
		FightingStyle.RANGED_BOW:
			attack_command = RangedAttackCommand.new()

	
	var params := AttackStateParams.new()
	params.attacker = self
	params.target = target
	params.animation_parameter = "parameters/StateMachine/Attack/conditions/melee_1"
	attack_command.execute(state_machine, params)
