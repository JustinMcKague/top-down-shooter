extends CanvasLayer

var scene: PackedScene

@export var game_over: Label

@export var subtext: Label

@export var color: ColorRect

func _ready() -> void:
	visible = false
	PlayerVariables.game_over.connect(_on_player_death)
	scene = load("res://game_scene.tscn")
	game_over = $ColorRect/Label
	subtext = $ColorRect/Label2
	color = $ColorRect
	
func _on_player_death():
	visible = true
	
func _process(delta: float) -> void:
	if self.visible:
		var tween = get_tree().create_tween()
		await tween.tween_property(color, "modulate:a", 1, 1.5)
		await tween.tween_property(game_over, "modulate:a", 1, 1.5)
		await tween.tween_property(subtext, "modulate:a", 1, 1)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('shoot') && Global.playerHealth <= 0:
		hide_all()
		PlayerVariables.restart.emit()

func hide_all():
	get_tree().reload_current_scene()
	Global.playerHealth = 10
	visible = false
	PlayerVariables.batteryCharge = 100
