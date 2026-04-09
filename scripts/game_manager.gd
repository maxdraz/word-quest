class_name GameManager
extends Node


@export var player_1 : Character
@export var player_2 : Character
@export var enemy : Character
@export var health_players : Health
@export var health_bar_players : ProgressBar
@export var health_bar_enemy : ProgressBar


func _ready() -> void:
	init()	


func init() -> void:
	enemy.health.changed.connect(_on_enemy_health_changed)
	health_players.changed.connect(_on_players_health_changed)
	
	player_1.init()
	player_2.init()
	player_1.health = health_players
	player_2.health = health_players
	enemy.init()
	player_1.look_at_target(enemy, true)
	player_2.look_at_target(enemy, true)
	combat_loop()


func combat_loop():
	while true:
		await get_tree().create_timer(3.0).timeout
		player_1.attack(enemy)
		await get_tree().create_timer(3.0).timeout
		player_2.attack(enemy)
		await get_tree().create_timer(3.0).timeout
		var rand = randf()
		if rand <= 0.5:
			enemy.attack(player_1)
		else:
			enemy.attack(player_2)


func _on_enemy_health_changed(previous: int, current: int, max: int) -> void:
	health_bar_enemy.value = current / float(max)


func _on_players_health_changed(previous: int, current: int, max: int) -> void:
	health_bar_players.value = current / float(max)
