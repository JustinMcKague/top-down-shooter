extends Node

enum DialogueType {
	Preamble,
	Brief,
	Death,
	Boss,
}

class Dialogue:
	var speaker: CharacterName
	var text: String
	
	func _init(character: CharacterName, dialogue: String) -> void:
		speaker = character
		text = dialogue

enum CharacterName {
	Jack, 
	Colonel, 
	Boss, 
	Narrator
	}

var dialogue_dicts: Dictionary = {}


func _ready() -> void:
	assign_preamble_dialogue()
	assign_brief_dialogue()
	assign_death_dialogue()
	assign_boss_dialogue()
	
func assign_preamble_dialogue():
	dialogue_dicts[DialogueType.Preamble] = [
		Dialogue.new(CharacterName.Narrator, "Far in the future, humanity would take to the stars and inhabit hundreds of planets across the galaxy."), 
		Dialogue.new(CharacterName.Narrator, "As humanity's reach grew, so too did their need for resources."), 
		Dialogue.new(CharacterName.Narrator, "To mitigate unrest, the planets appointed representatives for a united governing body."),
		Dialogue.new(CharacterName.Narrator, "But, this government grew corrupt and ousted the representatives from planets with lower value resources."),
		Dialogue.new(CharacterName.Narrator, "The government decided to keep the valuable resources to themselves in order to keep the civilizations on 'lesser planets' weaker."),
		Dialogue.new(CharacterName.Narrator, "Because of this oppression, the weaker planets banded together to form a rebel force."),
		Dialogue.new(CharacterName.Narrator, "They named their rebel force The Food Chain of Command, and each tier on the food chain is tasked with reclaiming different resources."),
		Dialogue.new(CharacterName.Narrator, "Jack is one of the rebel forces' ace pilots. He is tasked with the noble mission of reclaiming seeds for nutrient dense agriculture."),
		Dialogue.new(CharacterName.Narrator, "This is his story...")
	]
	
func assign_brief_dialogue():
	dialogue_dicts[DialogueType.Brief] = [
	Dialogue.new(CharacterName.Colonel, "Jack, you've been tasked with infiltrating enemy territory and clearing a path for our troops to take control of the enemy's cruiser."),
	Dialogue.new(CharacterName.Colonel, "We've outfitted you with the most advanced R4b-b1t ship our scientists could create, but its energy stores are low due to budget cuts."),
	Dialogue.new(CharacterName.Colonel, "So be sure to look out for some energy to keep the lights running and find some tools that can help you get stronger!"),
	Dialogue.new(CharacterName.Jack, "You gave me this ship because I'm your ace pilot! Right, Colonel?"),
	Dialogue.new(CharacterName.Colonel, "Yes, Jack. You are the ace pilot of the Small Rodent tier of our Food Chain of Command. Be proud of that, son."),
	Dialogue.new(CharacterName.Jack, "Doesn't sound quite as impressive when you put it like that..."),
	Dialogue.new(CharacterName.Colonel, "Complete your mission and you might just get promoted to Slightly Larger Rodent tier."),
	Dialogue.new(CharacterName.Jack, "You can count on me, Colonel! But, is this ship really the best one for the job? It doesn't seem very intimidating..."),
	Dialogue.new(CharacterName.Colonel, "Trust me, Jack. This is the perfect ship for the enemies you're up against."),
	Dialogue.new(CharacterName.Colonel, "Fight well, and I'll see you on the other side, Jack."),
	Dialogue.new(CharacterName.Jack, "Yes, Sir!")
	]
	
		
func assign_death_dialogue():
	dialogue_dicts[DialogueType.Death] = [
	Dialogue.new(CharacterName.Colonel, "Jack? Jaaaaaaaaaack!!!"),
	Dialogue.new(CharacterName.Colonel, "He's hopping along in heaven now..."),
	Dialogue.new(CharacterName.Colonel, "Uhhhh, yes. HQ, I need you to bring out clone Jack number " + str(Global.attempt + 1)),
	Dialogue.new(CharacterName.Colonel, "So much for that promotion..."),
	]


func assign_boss_dialogue():
	dialogue_dicts[DialogueType.Boss] = [
	Dialogue.new(CharacterName.Jack, "Whoa... That's one big turtle."),
	Dialogue.new(CharacterName.Boss, "I've actually slimmed down quite a bit after eating all these vegetables."),
	Dialogue.new(CharacterName.Jack, "No, no! You look great! Really.."),
	Dialogue.new(CharacterName.Colonel, "Jack... Focus on the mission."),
	Dialogue.new(CharacterName.Jack, "Right, I'm here to take you down!"),
	Dialogue.new(CharacterName.Boss, "I'd like to see you try.")
	]
	
func get_character_name(dialogue_type: DialogueType, arr_index: int) -> CharacterName:
	if dialogue_dicts.has(dialogue_type) and arr_index < dialogue_dicts[dialogue_type].size():
		var dialogue_inst = dialogue_dicts[dialogue_type][arr_index]
		return dialogue_inst.speaker
	else:
		print("Did not work")
		return -1
	
func get_dialogues_by_type(dialogue_type: DialogueType) -> Array:
	return dialogue_dicts.get(dialogue_type, [])
	
