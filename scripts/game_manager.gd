class_name GameManager
extends Node


@export var player_1 : Character
@export var player_2 : Character
@export var enemy : Character
@export var health_players : Health
@export var health_bar_players : ProgressBar
@export var health_bar_enemy : ProgressBar
@export var word_database : WordDatabase
@export var labels : Array[Label]


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
		refresh_words()
		await get_tree().create_timer(3.0).timeout
		player_1.attack(enemy)
		refresh_words()		
		await get_tree().create_timer(3.0).timeout
		player_2.attack(enemy)
		refresh_words()
		await get_tree().create_timer(3.0).timeout
		refresh_words()
		var rand = randf()
		if rand <= 0.5:
			enemy.attack(player_1)
		else:
			enemy.attack(player_2)


func refresh_words():
	print(word_database.database.size())
	print(word_database.database[0])
	var word_1 = word_database.database.pick_random()
	var word_2 = word_database.database.pick_random()
	var word_3 = word_database.database.pick_random()
	var word_4 = word_1

	labels[0].text = word_1.english
	labels[1].text = word_2.polish
	labels[2].text = word_3.lithuanian
	labels[3].text = word_4.polish
	


func _on_enemy_health_changed(previous: int, current: int, max: int) -> void:
	health_bar_enemy.value = current / float(max)


func _on_players_health_changed(previous: int, current: int, max: int) -> void:
	health_bar_players.value = current / float(max)
