extends Node2D

@export var carrot_scene : PackedScene
@export var beet_scene : PackedScene

func _on_spawn_timeer_timeout() -> void:
	var rng = RandomNumberGenerator.new()
	var randomX = rng.randi_range(50, 440)
	var randomEnemy = rng.randi_range(1, 2)
	
	if randomEnemy == 1:
		var carrot = carrot_scene.instantiate()
		get_tree().current_scene.add_child(carrot)
		carrot.position.y = 0
		carrot.position.x = randomX
	
	if randomEnemy == 2:
		var beet = beet_scene.instantiate()
		get_tree().current_scene.add_child(beet)
		beet.position.y = 0
		beet.position.x = randomX
