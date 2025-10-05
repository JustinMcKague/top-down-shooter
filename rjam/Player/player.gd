extends CharacterBody2D

@export var bullet_scene : PackedScene

var speed = 350

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		get_tree().current_scene.add_child(bullet)
		bullet.position = position
		
	$AnimatedSprite2D.play("idel")
	
	#self.move_local_y(0.5)
	
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
	if area.is_in_group("enemy_bullet"):
		Global.playerHealth -= 1
