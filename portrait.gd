extends TextureRect

@export var character_portraits: Array[Texture]

var portrait_dict: Dictionary

func _ready() -> void:
	portrait_dict = {
		DialogueGlobal.CharacterName.Jack: character_portraits[0], 
		DialogueGlobal.CharacterName.Colonel: character_portraits[1],
		DialogueGlobal.CharacterName.Boss: character_portraits[2],
		DialogueGlobal.CharacterName.Narrator: character_portraits[3],
		}
	
func display_portrait(character):
	texture = portrait_dict[character]

func _on_text_dialogue_changed(speaker: Variant) -> void:
	display_portrait(speaker)
