class_name WordMinigameScreen
extends Control


@export var labelMainWord : Label
@export var buttons : Array[Button]
signal word_selected(word: String)


func init(translated_language : LanguageType.Code, words: Array[Word]) -> void:
	visible = true
	labelMainWord.text = words[0].english
	for i in range(buttons.size()):
		buttons[i].text = words[i+1].get_in_language(translated_language)


func _ready() -> void:
	for button in buttons:
		button.pressed.connect(_on_button_pressed.bind(button))


func _on_button_pressed(button: Button) -> void:
	word_selected.emit(button.text)
	print(button.text + " pressed")
	visible = false