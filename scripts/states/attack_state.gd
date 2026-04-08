class_name AttackState
extends State


var params : AttackStateParams


func init(params : AttackStateParams) -> void:
	self.params = params


func enter() -> void:
	super.enter()
	params.attacker.animation_finished.connect(_on_animation_finished)
	params.attacker.animation_tree.set("parameters/Attack/blend_position", params.attacker.fighting_style)
	params.attacker.animation_state_machine.travel("Attack")	


func _on_animation_finished() -> void:
	exit()
