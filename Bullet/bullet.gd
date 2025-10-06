extends Area2D

func _physics_process(delta: float) -> void:
	move_local_y(-5)
	
func _on_expire_timeout() -> void:
	self.queue_free()

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('enemy'):
		self.queue_free()
