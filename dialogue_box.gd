extends Label

signal dialogue_changed(speaker)

var current_char: int = 0
var total_chars: int
@export var time_between_char: float = 0.1

@export var dialogue_box: Control

var lines = []
var current_line: int = 0

var current_dialogue_type
var random_int

func _ready() -> void:
	visible_characters = 0
	$Timer.wait_time = time_between_char
	$Timer.start()
	load_dialogue(DialogueGlobal.DialogueType.Preamble)
	generate_random_index()

func generate_random_index() -> int: # Call this function on game restart
	random_int = randi_range(0, lines.size() - 1)
	return random_int

func show_dialogue_box():
	dialogue_box.visible = true
	
func load_dialogue(diaType): # Call this function on Game Start and when the player reaches the boss battle
	current_dialogue_type = diaType
	if diaType == DialogueGlobal.DialogueType.Death:
		var dialogues = DialogueGlobal.get_dialogues_by_type(diaType)
		for dialogue in dialogues:
			lines.append(dialogue)
			generate_random_index()
		display_one_liner(random_int)
	else:
		current_line = 0
		var dialogues = DialogueGlobal.get_dialogues_by_type(diaType)
		for dialogue in dialogues:
			lines.append(dialogue)
		display_dialogue()

func display_dialogue(): 
	dialogue_changed.emit(DialogueGlobal.get_character_name(current_dialogue_type, current_line))
	text = lines[current_line].text
	total_chars = lines[current_line].text.length()
	current_char += 1
	visible_characters = current_char
	if current_char >= total_chars:
		$Timer.stop()
		
		
func display_one_liner(index): # This function selects a random death line to say
	dialogue_changed.emit(DialogueGlobal.get_character_name(current_dialogue_type, index))
	var random_one_liner = lines[index]
	text = random_one_liner.text
	total_chars = random_one_liner.text.length()
	current_char += 1
	visible_characters = current_char
	if current_char >= total_chars:
		$Timer.stop()
	
func _on_button_pressed(): # This function will be put inside a signal based on a button press to progress dialogue
	current_line += 1
	current_char = 0
	if current_line >= lines.length():
		hide_dialogue_box()
	else:
		$Timer.start()
		display_dialogue()

func hide_dialogue_box():
	dialogue_box.visible = false


func _on_timer_timeout() -> void:
	if current_dialogue_type == DialogueGlobal.DialogueType.Death:
		display_one_liner(random_int)
	else:
		display_dialogue()
