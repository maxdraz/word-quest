class_name MoveToState
extends State

var target_position : Vector3
var character : Character


func init(target_position: Vector3, character: Character) -> void:
    self.target_position = target_position
    self.character = character
    