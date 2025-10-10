extends Node2D

@export var speed: float = 4.5

var anim

func _ready() -> void:
	anim = $AnimatedSprite2D
	anim.play('default')
	
func _physics_process(delta: float) -> void:
	move_local_y(speed)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('player'):
		anim.stop()
		anim.play('impact')
		$AudioStreamPlayer2D.play()

func _on_animated_sprite_2d_animation_finished() -> void:
	self.queue_free()

func _on_timeout_timeout() -> void:
	self.queue_free()
