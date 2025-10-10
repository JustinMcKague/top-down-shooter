extends Area2D

func _ready() -> void:
	rotate(-0.1)
func _process(delta: float) -> void:
	move_local_y(3)


func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('player'):
		$AnimatedSprite2D.play('impact')

func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()
