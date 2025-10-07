extends CharacterBody2D

@export var enemy_bullet_scene : PackedScene

@export var damage_anim: AnimatedSprite2D

var carrot_health = 2
var rng = RandomNumberGenerator.new()
var randomX = rng.randi_range(-1, 1)

var alive: bool = true

@export var energy: PackedScene

var sprite: AnimatedSprite2D

func _ready() -> void:
	sprite = $AnimatedSprite2D

func  _physics_process(delta: float):
	move_local_y(1)
	move_local_x(randomX)
	$AnimatedSprite2D.play("idel")
	
	if position.y > 1000:
		self.queue_free()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('player'):
		carrot_health = 0
	if area.is_in_group("bullet"):
		carrot_health -= 1
		var tween = create_tween()
		tween.tween_property(sprite, "modulate", Color.RED, 0.15)
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.15)
		if carrot_health == 1:
			damage_anim.visible = true
			damage_anim.play('damage')
		if carrot_health <= 0:
			$HideTimer.start()
			alive = false
			$HitBox.monitoring = false
			$HitBox.monitorable = false
			damage_anim.play('explode')
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

func _on_shoot_timer_timeout() -> void:
	if alive:
		var bullet = enemy_bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.position = position + Vector2(0, 26)
		
func _on_animated_sprite_2d_2_animation_finished() -> void:
	self.queue_free()


func _on_hide_timer_timeout() -> void:
	$AnimatedSprite2D.visible = false
