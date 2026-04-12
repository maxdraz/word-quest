class_name Character
extends Node3D


enum FightingStyle 
{
	MELEE_1H = 0, 
	RANGED_BOW = 1, 
}

@export var animation_tree : AnimationTree
@export var fighting_style : FightingStyle
@export var health : Health
@export var damage := 50
@export var projectile_scene : PackedScene
@export var deal_damage_sfx : AudioStream
@export var deal_damage_vfx_scene : PackedScene
@export var audio_stream_player : AudioStreamPlayer
var animation_state_machine : AnimationNodeStateMachinePlayback
var state_machine := StateMachine.new()
var current_target : Character
signal animation_finished


func init() -> void:
	animation_state_machine = animation_tree.get("parameters/playback") 
	var idle_state = IdleState.new()
	var params = IdleStateParams.new()
	params.character = self
	idle_state.init(params)
	state_machine.init(idle_state)
	health.changed.connect(_on_health_changed)


func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)


func deal_damage():
	if !current_target: return
	current_target.take_damage(damage)
	audio_stream_player.stream = deal_damage_sfx
	audio_stream_player.play()
	var deal_damage_vfx = deal_damage_vfx_scene.instantiate() as GPUParticles3D
	get_tree().current_scene.add_child(deal_damage_vfx)
	var to_target = global_position.direction_to(current_target.global_position)
	deal_damage_vfx.global_position = current_target.global_position - (to_target * 2) + (Vector3.UP * 2)
	deal_damage_vfx.emitting = true
	await get_tree().create_timer(deal_damage_vfx.lifetime).timeout
	deal_damage_vfx.free()
	

func take_damage(dmg: float):
	health.add_health(-dmg)
	if health.current <= 0:
		die()
	else:
		get_hurt()


func die() -> void:
	var command := DieCommand.new()
	command.execute(state_machine, self)


func get_hurt() -> void:
	var params = HurtStateParams.new()
	params.character = self
	var hurt_command = HurtCommand.new()
	hurt_command.execute(state_machine, params)


func _animation_finished() -> void:
	animation_finished.emit()


func look_at_target(target: Node3D, instant:= false) -> void:
	if instant:
		look_at(target.position, Vector3.UP, true)
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
	current_target = target
	var attack_command
	match fighting_style:
		FightingStyle.MELEE_1H:
			attack_command = MeleeAttackCommand.new()
		FightingStyle.RANGED_BOW:
			attack_command = RangedAttackCommand.new()	
	var params := AttackStateParams.new()
	params.attacker = self
	params.target = target
	attack_command.execute(state_machine, params)
	if projectile_scene:
		var projectile = projectile_scene.instantiate() as Projectile
		get_tree().current_scene.add_child(projectile)
		projectile.init(self, target)
		projectile.finished.connect(deal_damage)


func _on_health_changed(previous: int, current: int, max: int) -> void:
	if current <= 0:
		print(name + "died")
