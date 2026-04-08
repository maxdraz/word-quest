class_name GameManager
extends Node


@export var player_1 : Character
@export var player_2 : Character
@export var enemy : Character


func _ready() -> void:
	player_1.init()
	player_2.init()
	enemy.init()

	player_1.look_at_target(enemy, true)
	player_2.look_at_target(enemy, true)
