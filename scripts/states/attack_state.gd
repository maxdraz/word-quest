class_name AttackState
extends State


const is_attack_parameter := "parameters/StateMachine/conditions/is_attack"
var params : AttackStateParams


func init(params : AttackStateParams) -> void:
	self.params = params


func enter() -> void:
	super.enter()
	params.attacker.animation_finished.connect(_on_animation_finished)
	params.attacker.animation_tree.set(is_attack_parameter, true)


func cancel() -> void:
	super.cancel()
	params.attacker.animation_tree.set(is_attack_parameter, false)


func exit() -> void:
	super.exit()
	print("called")
	params.attacker.animation_tree.set(is_attack_parameter, false)


func _on_animation_finished() -> void:
	exit()
