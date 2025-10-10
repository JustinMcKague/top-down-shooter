extends CharacterBody2D

@export var beet_bullet_scene : PackedScene

var rng = RandomNumberGenerator.new()

@export var energy: PackedScene

signal boss_time(type: FlowManager.EnemyType, position: Vector2)

@export var damaged_anim: AnimatedSprite2D

func _process(delta: float) -> void:
	move_local_y(3)

func _on_shooting_timer_timeout() -> void:
		var bullet = beet_bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.position = position + Vector2(0, 26)

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet") or area.is_in_group('player'):
		$HideTimer.start()
		damaged_anim.visible = true
		$CollisionShape2D.set_deferred("disabled", true)
		$HitBox/CollisionShape2D.set_deferred("disabled", true)
		if drop_chance():
			drop_energy()
		damaged_anim.play('explode')
		$"Explosion Sound".pitch_scale = randi_range(0.5, 1.5)
		$"Explosion Sound".play()

func drop_chance() -> bool:
	var drop = rng.randf_range(0, 1)
	if drop <= 0.2:
		return true
	else:
		return false

func drop_energy():
	var energy_inst = energy.instantiate()
	get_tree().current_scene.add_child(energy_inst)
	energy_inst.global_position = global_position


func _on_damage_animation_finished() -> void:
	self.queue_free()

func _on_hide_timer_timeout() -> void:
	$AnimatedSprite2D.visible = false
