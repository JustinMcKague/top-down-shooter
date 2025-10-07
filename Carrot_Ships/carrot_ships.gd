extends CharacterBody2D

@export var enemy_bullet_scene : PackedScene

@export var damage_anim: AnimatedSprite2D

var carrot_health = 2
var rng = RandomNumberGenerator.new()
var randomX = rng.randi_range(-1, 1)

var alive: bool = true


func  _physics_process(delta: float):
	move_local_y(1)
	move_local_x(randomX)
	$AnimatedSprite2D.play("idel")
	
	if position.y > 1000:
		self.queue_free()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		carrot_health -= 1
		if carrot_health == 1:
			damage_anim.visible = true
			damage_anim.play('damage')
		if carrot_health <= 0:
			alive = false
			damage_anim.play('explode')

func _on_shoot_timer_timeout() -> void:
	if alive:
		var bullet = enemy_bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.position = position + Vector2(0, 26)
		
func _on_animated_sprite_2d_2_animation_finished() -> void:
	self.queue_free()
