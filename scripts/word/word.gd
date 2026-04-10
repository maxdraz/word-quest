class_name Word
extends Resource

@export var english : String
@export var polish : String
@export var lithuanian : String


func get_in_language(language: LanguageType.Code) -> String:
    match language:
        LanguageType.Code.EN:
            return english 
        LanguageType.Code.PL:
            return polish 
        LanguageType.Code.LT:
            return lithuanian
    
    return english