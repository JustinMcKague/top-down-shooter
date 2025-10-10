extends Area2D

var speed = 1

func _ready() -> void:
	$AudioStreamPlayer2D.pitch_scale = randi_range(0.5, 1.5)

func _physics_process(delta: float) -> void:
	move_local_y(-5 * speed)
	
func _on_expire_timeout() -> void:
	self.queue_free()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		speed = 0
		$AnimatedSprite2D.play('impact')

func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()
