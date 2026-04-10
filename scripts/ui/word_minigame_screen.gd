class_name WordMinigameScreen
extends Control


@export var labelMainWord : Label
@export var buttons : Array[Button]
@export var correct_sfx : AudioStreamPlayer
@export var incorrect_sfx : AudioStreamPlayer
signal word_selected(word: String)

var correct_word : String


func init(translated_language : LanguageType.Code, words: Array[Word]) -> void:
	visible = true
	labelMainWord.text = words[0].english
	correct_word = words[0].get_in_language(translated_language)
	for i in range(buttons.size()):
		buttons[i].text = words[i+1].get_in_language(translated_language)


func _ready() -> void:
	for button in buttons:
		button.pressed.connect(_on_button_pressed.bind(button))


func _on_button_pressed(button: Button) -> void:
	word_selected.emit(button.text)
	print(button.text + " pressed")
	visible = false
	if button.text == correct_word:
		correct_sfx.pitch_scale = randf_range(0.9, 1.1)
		correct_sfx.play()
	else:
		incorrect_sfx.pitch_scale = randf_range(0.9, 1.1)
		incorrect_sfx.play()
