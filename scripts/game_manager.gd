class_name GameManager
extends Node


@export var player_1 : Character
@export var player_2 : Character
@export var enemy : Character
@export var health_players : Health
@export var health_bar_players : ProgressBar
@export var health_bar_enemy : ProgressBar
@export var word_database : WordDatabase
@export var word_minigame_screen : WordMinigameScreen
@export var summary_screen : SummaryScreen
var database : Array[Word]
var current_word : Word
var current_language : LanguageType.Code
var current_attacker : Character
var is_game_over : bool


func _ready() -> void:
	init()	


func init() -> void:
	database = word_database.database.duplicate()
	word_minigame_screen.visible = false
	word_minigame_screen.word_selected.connect(_on_word_selected)
	summary_screen.play_again_pressed.connect(_on_play_again_pressed)
	summary_screen.visible = false
	enemy.health.changed.connect(_on_enemy_health_changed)
	health_players.changed.connect(_on_players_health_changed)
	current_language = LanguageType.Code.PL if randf() <= 0.5 else LanguageType.Code.LT
	
	
	player_1.health = health_players
	player_2.health = health_players
	player_1.init()
	player_2.init()
	enemy.init()
	player_1.look_at_target(enemy, true)
	player_2.look_at_target(enemy, true)
	await get_tree().create_timer(2).timeout
	refresh_words()


func attack(attacker : Character, target: Character):
	await get_tree().create_timer(0.25).timeout
	attacker.attack(target)
	attacker.state_machine.queue_finished = func(): refresh_words()


func refresh_words():
	if is_game_over: return
	word_minigame_screen.visible = true
	current_language = LanguageType.Code.PL if current_language == LanguageType.Code.LT else LanguageType.Code.LT
	current_attacker = player_1 if current_language == LanguageType.Code.LT else player_2

	database.shuffle()
	current_word = database[0]
	var words : Array[Word] = []
	words.append(current_word)
	words.append(database[1])
	words.append(database[2])
	words.shuffle()
	words.push_front(current_word)
	word_minigame_screen.init(current_language, words)

	enemy.look_at_target(current_attacker)


func _on_word_selected(word: String) -> void:
	var is_correct = current_word.get_in_language(current_language) == word
	var attacker = current_attacker if is_correct else enemy
	var target = current_attacker if !is_correct else enemy
	attack(attacker, target)

	
func _on_enemy_health_changed(previous: int, current: int, max: int) -> void:
	health_bar_enemy.value = current / float(max)
	if current <= 0:
		game_over(true)


func _on_players_health_changed(previous: int, current: int, max: int) -> void:
	health_bar_players.value = current / float(max)
	if current <= 0:
		player_1.die()
		player_2.die()
		game_over(false)


func _on_play_again_pressed() -> void:
	get_tree().reload_current_scene()


func game_over(is_victory: bool) -> void:
	is_game_over = true
	word_minigame_screen.visible = false
	health_bar_enemy.visible = false
	health_bar_players.visible = false
	await get_tree().create_timer(1.5).timeout
	summary_screen.visible = true
	summary_screen.init(is_victory)
