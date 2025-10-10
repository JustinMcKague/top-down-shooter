extends CharacterBody2D

@export var boss_health: int = 50
@export var damaged_anim: AnimatedSprite2D

var boss_max_health = 50

@export var explosions: Array[AnimatedSprite2D]
@export var explosions_parent: Node2D

@export var death_timer: Timer

@export var final_pos: Vector2

var sprite: AnimatedSprite2D

var shake_count = 10
var shake_amount = 4

var explosion_delay

func _ready() -> void:
	explosion_delay = $"Explosion Sound/timeperexplode"
	sprite = $AnimatedSprite2D
	FlowManager.increment_time = false
	$HitBox.monitoring = false
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", final_pos, 4)
	explosions_parent.visible = false
	BossManager.tween_ended.connect(_on_tween_ended)
	BossManager.boss_spawned.connect(_on_boss_spawn)
	
func _on_boss_spawn():
	BossManager.phase_timer.start()

func _on_tween_ended():
	$HitBox.monitoring = true

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area.is_in_group('bullet'):
		boss_health -= 1
		var tween = create_tween()
		tween.tween_property(sprite, "modulate", Color.RED, 0.15)
		tween.tween_property(sprite, "modulate", Color.WHITE, 0.15)
		check_health_threshold()
		

func check_health_threshold():
	if boss_health <= (boss_max_health * 0.75) and boss_health > (boss_max_health * 0.5):
		damaged_anim.visible = true
		damaged_anim.play('level1')
	if boss_health <= boss_max_health * 0.5 and boss_health > boss_max_health * 0.25:
		damaged_anim.play('level2')
	if boss_health <= boss_max_health * 0.25:
		damaged_anim.play('level3')
	if boss_health <= 0 and death_timer.is_stopped():
		death_timer.start()
		print('boss is dead')
		BossManager.alive = false
		explode()
		
func explode():
	$AnimatedSprite2D/AnimationPlayer.play('death')
	explosions_parent.visible = true
	explosion_delay.start()
	for i in explosions.size():
		explosions[i].play('explosion')

func _on_death_delay_timeout() -> void:
	print('death timer')
	PlayerVariables.win.emit()

func _on_timeperexplode_timeout() -> void:
	explosion_delay.wait_time = randi_range(0.25, 0.5)
	$"Explosion Sound".play()
