extends Node2D

var enemy_dict: Dictionary

@export var enemy_prefabs: Array[PackedScene]

var rng = RandomNumberGenerator.new()

var spawn_positions = [Vector2(80, 0), Vector2(240, 0), Vector2(400, 0)]


func _ready() -> void:
	enemy_dict = {
		FlowManager.EnemyType.CARROT: enemy_prefabs[0],
		FlowManager.EnemyType.RADISH: enemy_prefabs[1],
		FlowManager.EnemyType.CORN: enemy_prefabs[2],
		FlowManager.EnemyType.BOSS: enemy_prefabs[3]
	}
	FlowManager.enemy_spawn_time.connect(_on_spawn_time_reached)
	BossManager.attack.connect(_on_attack_signal)
	FlowManager.final_enemy_spawned.connect(_on_boss_time)
	PlayerVariables.restart.connect(_on_restart)

func _on_restart():
	for n in get_children():
		remove_child(n)
		n.queue_free()

func _on_spawn_time_reached(enemy: FlowManager.EnemySpawnInfo):
	var enemy_inst = enemy_dict[enemy.type].instantiate()
	self.add_child(enemy_inst)
	enemy_inst.global_position = enemy.position
	
func spawn_enemy(type: FlowManager.EnemyType, position: Vector2):
	var enemy_inst = enemy_dict[type].instantiate()
	self.add_child(enemy_inst)
	enemy_inst.global_position = position

func _on_attack_signal(type: BossManager.BossAttack):
	if type != BossManager.BossAttack.REINFORCE:
		return
	else:
		for i in enemy_prefabs.size() - 1:
			spawn_enemy(enemy_dict.keys()[select_random_enemy()], spawn_positions[i])
		
func select_random_enemy() -> int:
	var random_index = randi_range(0, 2)
	return random_index
	
func _on_boss_time():
	spawn_enemy(FlowManager.EnemyType.BOSS, Vector2(240, -100))
	BossManager.boss_spawned.emit()
