extends Area2D

var x_direction: float = 0.75
@export var speed: float

func _ready() -> void:
	$AnimatedSprite2D.play("default")

func set_x_direction(x_dir: float):
	x_direction *= x_dir

func _physics_process(delta: float) -> void:
	move_local_x(x_direction * speed)
	move_local_y(speed)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('player'):
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.play("impact")

func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()

func _on_timer_timeout() -> void:
	self.queue_free()
