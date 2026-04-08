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
	combat_loop()


func combat_loop():
	while true:
		player_1.attack(enemy)
		await get_tree().create_timer(3.0).timeout
		player_2.attack(enemy)
		await get_tree().create_timer(3.0).timeout
		enemy.attack(player_1)
