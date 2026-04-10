class_name SummaryScreen
extends Control


@export var container_victory : Control
@export var container_defeat : Control
@export var button_play_again : Button
signal play_again_pressed


func _ready() -> void:
	button_play_again.pressed.connect(func(): play_again_pressed.emit())


func init(is_victory: bool) -> void:
	container_victory.visible = is_victory
	container_defeat.visible = !is_victory