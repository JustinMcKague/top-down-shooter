extends CharacterBody2D

@export var enemy_bullet_scene : PackedScene
@export var enemy_right_bullet_scene : PackedScene
@export var enemy_left_bullet_scene : PackedScene

var corn_health = 3

@export var damaged_anim: AnimatedSprite2D

func  _physics_process(delta: float):
	move_local_y(1)
	$AnimatedSprite2D.play("idel")
	
	if position.y > 1000:
		self.queue_free()


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		corn_health -= 1
		
	if corn_health == 2:
		damaged_anim.visible = true
		damaged_anim.play('level1')
	elif corn_health == 1:
		damaged_anim.play('level2')
		
	if corn_health <= 0:
		damaged_anim.play('explode')

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
