class_name DieState
extends State


var character : Character 


func init(character: Character) -> void:
    self.character = character


func enter() -> void:
    character.animation_state_machine.travel("Die")