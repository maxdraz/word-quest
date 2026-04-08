class_name HurtState
extends State


var params: HurtStateParams


func init(params: HurtStateParams):
	self.params = params


func enter() -> void:
	super.enter()
	params.character.animation_state_machine.travel("Hurt")
