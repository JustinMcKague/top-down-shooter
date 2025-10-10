extends Label

signal dialogue_changed(speaker)

var current_char: int = 0
var total_chars: int
@export var time_between_char: float = 0.1

@export var dialogue_box: CanvasLayer

var lines = []
var current_line: int = 0

var current_dialogue_type
var random_int

@export var brief_timer: Timer
@export var blackout: ColorRect

func _ready() -> void:
	visible_characters = 0
	$Timer.wait_time = time_between_char
	$Timer.start()
	load_dialogue(DialogueGlobal.DialogueType.Preamble)
	generate_random_index()
	PlayerVariables.player_death.connect(load_dialogue)
	BossManager.tween_ended.connect(_on_boss_time)
	PlayerVariables.restart.connect(_on_restart)
	
func _on_restart():
	visible_characters = 0
	current_char = 0
	current_line = 0

func generate_random_index() -> int: # Call this function on game restart
	random_int = randi_range(0, DialogueGlobal.dialogue_dicts[DialogueGlobal.DialogueType.Death].size() - 1)
	print('Random int = ' + str(random_int))
	return random_int

func show_dialogue_box():
	dialogue_box.visible = true
	FlowManager.increment_time = false
	PlayerVariables.can_fire = false
	PlayerVariables.battery_decaying = false
	$Timer.start()
	
func load_dialogue(diaType): # Call this function on Game Start and when the player reaches the boss battle
	current_dialogue_type = diaType
	current_char = 0
	lines.clear()
	current_line = 0
	text = ""
	if current_dialogue_type == DialogueGlobal.DialogueType.Death:
		current_char = 0
		var dialogues = DialogueGlobal.get_dialogues_by_type(current_dialogue_type)
		for dialogue in dialogues:
			lines.append(dialogue)
		generate_random_index()
		current_line = random_int
		display_one_liner(random_int)
	else:
		current_line = 0
		current_char = 0
		var dialogues = DialogueGlobal.get_dialogues_by_type(current_dialogue_type)
		print(current_dialogue_type)
		for dialogue in dialogues:
			lines.append(dialogue)
		display_dialogue()

func display_dialogue(): 
	show_dialogue_box()
	$AudioStreamPlayer2D.pitch_scale = randi_range(0.9, 1.2)
	$AudioStreamPlayer2D.play()
	dialogue_changed.emit(DialogueGlobal.get_character_name(current_dialogue_type, current_line))
	text = lines[current_line].text
	total_chars = lines[current_line].text.length()
	current_char += 1
	visible_characters = current_char
	if current_char >= total_chars:
		$Timer.stop()
		
		
func display_one_liner(index): # This function selects a random death line to say
	show_dialogue_box()
	dialogue_changed.emit(DialogueGlobal.get_character_name(current_dialogue_type, index))
	var random_one_liner = lines[index]
	text = random_one_liner.text
	total_chars = random_one_liner.text.length()
	current_char += 1
	visible_characters = current_char
	if current_char >= total_chars:
		$Timer.stop()
	
func _input(event: InputEvent) -> void: # This function will be put inside a signal based on a button press to progress dialogue
	if event.is_action_pressed("shoot"):
		if current_char < total_chars:
			current_char = total_chars
		else:
			if current_dialogue_type == DialogueGlobal.DialogueType.Death:
				hide_dialogue_box()
				Global.restart.emit()
			else:
				current_line += 1
				current_char = 0
				if current_line >= lines.size():
					hide_dialogue_box()
					if current_dialogue_type == DialogueGlobal.DialogueType.Preamble:
						FlowManager.increment_time = false
						PlayerVariables.can_fire = false
						brief_timer.start()
						fade()
						Global.brief_starting.emit()
				else:
					$Timer.start()
					display_dialogue()

func fade():
	var tween = get_tree().create_tween()
	tween.tween_property(blackout, "modulate:a", 0, 1.5)

func hide_dialogue_box():
	dialogue_box.visible = false
	FlowManager.increment_time = true
	PlayerVariables.can_fire = true
	PlayerVariables.battery_decaying = true
	lines.clear()


func _on_timer_timeout() -> void:
	if current_dialogue_type == DialogueGlobal.DialogueType.Death:
		display_one_liner(random_int)
	else:
		display_dialogue()

func _on_brief_delay_timeout() -> void:
	load_dialogue(DialogueGlobal.DialogueType.Brief)
	brief_timer.stop()
	
func _on_boss_time():
	load_dialogue(DialogueGlobal.DialogueType.Boss)
