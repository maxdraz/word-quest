class_name IdleState
extends State

var params : IdleStateParams


func init(params):
	self.params = params


func enter() -> void:
	params.character.animation_tree.set("parameters/Idle/blend_position", params.character.fighting_style)
	params.character.animation_state_machine.travel("Idle")
