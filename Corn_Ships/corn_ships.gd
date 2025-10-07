extends CharacterBody2D

@export var enemy_bullet_scene : PackedScene
@export var enemy_right_bullet_scene : PackedScene
@export var enemy_left_bullet_scene : PackedScene

var corn_health = 3

@export var damaged_anim: AnimatedSprite2D

@export var energy: PackedScene

var rng = RandomNumberGenerator.new()

var sprite: AnimatedSprite2D

func  _physics_process(delta: float):
	move_local_y(1)
	$AnimatedSprite2D.play("idel")
	sprite = $AnimatedSprite2D
	if position.y > 1000:
		self.queue_free()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('player'):
		corn_health = 0
	if area.is_in_group("bullet"):
		corn_health -= 1
		var tween = create_tween()
		tween.tween_property(sprite, "modulate", Color.RED, 0.15)
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.15)
	if corn_health == 2:
		damaged_anim.visible = true
		damaged_anim.play('level1')
	elif corn_health == 1:
		damaged_anim.play('level2')
		
	if corn_health <= 0:
		$HideTimer.start()
		$HitBox.monitoring = false
		$HitBox.monitorable = false
		damaged_anim.play('explode')
		if drop_chance():
			drop_energy()

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

func _on_shooting_timer_timeout() -> void:
		var bullet = enemy_bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.position = position + Vector2(0, 26)
		var right_bullet = enemy_right_bullet_scene.instantiate()
		get_tree().current_scene.add_child(right_bullet)
		right_bullet.position = position + Vector2(0, 26)
		var leftbullet = enemy_left_bullet_scene.instantiate()
		get_tree().current_scene.add_child(leftbullet)
		leftbullet.position = position + Vector2(0, 26)


func _on_damaged_animation_finished() -> void:
	self.queue_free()


func _on_hide_timer_timeout() -> void:
	$AnimatedSprite2D.visible = false
