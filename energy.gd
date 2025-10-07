extends Node2D

var speed = 2

func _physics_process(delta: float) -> void:
	move_local_y(speed)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('player'):
		self.queue_free()
