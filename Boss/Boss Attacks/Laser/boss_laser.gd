extends Node2D

var anim
var hit_box

func _ready() -> void:
	anim = $AnimatedSprite2D
	hit_box = $HitBox
	$Timer.start()
	anim.play('warming')
	hit_box.monitorable = false


func _on_animated_sprite_2d_animation_finished() -> void:
	anim.play('laser')
	hit_box.monitorable = true


func _on_timer_timeout() -> void:
	self.queue_free()
