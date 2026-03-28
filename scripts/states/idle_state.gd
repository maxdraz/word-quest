class_name IdleState
extends State

var params : IdleStateParams


func init(params):
	self.params = params


func enter() -> void:
	params.character.animation_tree.set("parameters/Movement/blend_amount", 0)
	pass


func cancel() -> void:	
	#params.character.animation_tree.set("parameters/StateMachine/conditions/is_idle", false)
	pass


func exit() -> void:	
	#params.character.animation_tree.set("parameters/StateMachine/conditions/is_idle", false)
	pass
