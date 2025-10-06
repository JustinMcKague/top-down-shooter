extends CharacterBody2D

@export var boss_health: int = 50

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('bullet'):
		boss_health -= 1
		check_health_threshold()

func check_health_threshold():
	if boss_health <= boss_health * 0.75:
		pass # ADD SPRITEANIMATION FOR DAMAGE
	elif boss_health <= boss_health * 0.5:
		pass
	elif boss_health <= boss_health * 0.25:
		pass
		
func explode():
	pass 
	# Spawn a bunch of little explosions and then destroy the game object
