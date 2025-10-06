extends CharacterBody2D

@export var beet_bullet_scene : PackedScene

signal boss_time(type: FlowManager.EnemyType, position: Vector2)

func _process(delta: float) -> void:
	move_local_y(3)


func _on_shooting_timer_timeout() -> void:
		var bullet = beet_bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.position = position + Vector2(0, 26)

func _on_hit_box_area_exited(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		self.queue_free()
