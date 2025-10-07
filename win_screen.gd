extends CanvasLayer

func _ready() -> void:
	PlayerVariables.win.connect(_on_win)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and visible:
		PlayerVariables.restart.emit()
		get_tree().change_scene_to_file("res://mainMenu/main_menu.tscn")

func _on_win():
	visible = true
