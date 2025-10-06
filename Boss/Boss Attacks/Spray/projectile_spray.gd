extends Node2D

@export var projectile_spray_count: int = 20

@export var emitters: Array[Node2D]

@export var bullet_spray: PackedScene

var projectiles_fired = 0

func _ready() -> void:
	BossManager.attack.connect(_on_attack_signal)
	
func _on_attack_signal(attack: BossManager.BossAttack):
	if attack != BossManager.BossAttack.SPRAY:
		return
	else:
		initiate_spray()
	
func initiate_spray():
	projectiles_fired = 0
	for i in emitters.size():
		fire_spray()

func fire_spray():
	$Delay.start()
	for emitter in emitters:
		var projectile = bullet_spray.instantiate()
		emitter.add_child(projectile)
		if emitter.global_position.x > 240:
			projectile.set_x_direction(-1)
		else:
			projectile.set_x_direction(1)
	projectiles_fired += 1
	if projectiles_fired >= projectile_spray_count:
		$Delay.stop()

func _on_delay_timeout() -> void:
	fire_spray()
