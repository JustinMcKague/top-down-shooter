extends CharacterBody2D

@export var boss_health: int = 50
@export var damaged_anim: AnimatedSprite2D

var boss_max_health = 50

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('bullet'):
		boss_health -= 1
		check_health_threshold()

func check_health_threshold():
	if boss_health <= boss_max_health * 0.75 and boss_health > boss_max_health * 0.5:
		damaged_anim.visible = true
		damaged_anim.play('level1')
	elif boss_health <= boss_max_health * 0.5 and boss_health > boss_max_health * 0.25:
		damaged_anim.play('level2')
	elif boss_health <= boss_max_health * 0.25:
		damaged_anim.play('level3')
	elif boss_health <= 0:
		BossManager.alive = false
		explode()
		
func explode():
	$DeathDelay.start()
	# Spawn a bunch of little explosions and then destroy the game object

func _on_death_delay_timeout() -> void:
	self.queue_free()
