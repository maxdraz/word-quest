class_name Character
extends CharacterBody3D

@export var animation_tree : AnimationTree
var state_machine : StateMachine

func init() -> void:
    state_machine = StateMachine.new()
    state_machine.init(IdleState.new())


func _physics_process(delta: float) -> void:
    state_machine.physics_process(delta)

