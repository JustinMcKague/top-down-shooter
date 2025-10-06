extends CharacterBody2D

@export var bullet_scene : PackedScene

var speed = 350

@export var damage_anim: AnimatedSprite2D

var alive: bool = true

func _ready() -> void:
	$AnimatedSprite2D.play('warmup')
	Global.brief_starting.connect(_on_brief_starting)

func _on_brief_starting():
	position.move_toward(position + Vector2.UP * 50, 10)

func _physics_process(delta: float) -> void:
	
	
	#self.move_local_y(0.5)
	if PlayerVariables.can_fire:
		var direction := Input.get_axis("left", "right")
		if direction: 
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		
		var direction2 := Input.get_axis("up", "down")
		if direction2:
			velocity.y = direction2 * speed
		else:
			velocity.y = move_toward(velocity.y, 0, speed)
		move_and_slide()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy_bullet") and alive:
		Global.playerHealth -= 1
		check_health()

func check_health():
	if Global.playerHealth <= 3 and Global.playerHealth > 1:
		damage_anim.visible = true
		damage_anim.play('level1')
	elif Global.playerHealth == 1:
		damage_anim.play('level2')
	if Global.playerHealth <= 0:
		alive = false
		damage_anim.play('explode')
		die()

func _on_fire_delay_timeout() -> void:
	if PlayerVariables.can_fire:
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.position = position + Vector2.UP * 50

func die():
	PlayerVariables.player_death.emit(DialogueGlobal.DialogueType.Death)

func _on_damaged_animation_finished() -> void:
	Global.attempt += 1
	self.queue_free()

func _on_animated_sprite_2d_animation_finished() -> void:
	$AnimatedSprite2D.play("idel")
