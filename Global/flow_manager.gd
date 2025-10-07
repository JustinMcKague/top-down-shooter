extends Node

enum EnemyType {
	CARROT,
	RADISH,
	CORN,
	BOSS
}

class EnemySpawnInfo:
	var type: EnemyType
	var position: Vector2
	
	func _init(enemy_type: EnemyType, pos: Vector2) -> void:
		type = enemy_type
		position = pos

signal enemy_spawn_time(spawn_info: EnemySpawnInfo)
signal final_enemy_spawned()

var phase1: Array[EnemySpawnInfo]
var phase2: Array[EnemySpawnInfo]

var right_pos: Vector2 = Vector2(380, 0)
var middle_pos: Vector2 = Vector2(240, 0)
var left_pos: Vector2 = Vector2(100, 0)

var boss_data

var increment_time: bool = false

var global_timer: Timer

var timer_index: int = 0

func _ready() -> void:
	# Initialize timer for spawn times
	global_timer = Timer.new()
	add_child(global_timer)
	global_timer.wait_time = 5.0
	global_timer.one_shot = false
	global_timer.autostart = false
	global_timer.connect("timeout", _on_global_timer_timeout)
	phase1 = [
		EnemySpawnInfo.new(EnemyType.CARROT, middle_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, right_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, left_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, right_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, left_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, middle_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, middle_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, left_pos),
		EnemySpawnInfo.new(EnemyType.RADISH, left_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, middle_pos),
		EnemySpawnInfo.new(EnemyType.RADISH, right_pos),
		EnemySpawnInfo.new(EnemyType.RADISH, left_pos),
		EnemySpawnInfo.new(EnemyType.RADISH, right_pos)
	]
	phase2 = [
		EnemySpawnInfo.new(EnemyType.CORN, middle_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, right_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, left_pos),
		EnemySpawnInfo.new(EnemyType.CORN, right_pos),
		EnemySpawnInfo.new(EnemyType.CORN, left_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, middle_pos),
		EnemySpawnInfo.new(EnemyType.RADISH, left_pos),
		EnemySpawnInfo.new(EnemyType.RADISH, right_pos),
		EnemySpawnInfo.new(EnemyType.RADISH, middle_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, right_pos),
		EnemySpawnInfo.new(EnemyType.CORN, right_pos),
		EnemySpawnInfo.new(EnemyType.CORN, middle_pos),
		EnemySpawnInfo.new(EnemyType.CARROT, left_pos),
		EnemySpawnInfo.new(EnemyType.RADISH, middle_pos),
		EnemySpawnInfo.new(EnemyType.RADISH, left_pos)
	]
	boss_data = EnemySpawnInfo.new(EnemyType.BOSS, Vector2.ZERO)
	PlayerVariables.restart.connect(_on_restart)

func _on_restart():
	timer_index = 0
	global_timer.wait_time = 5.0
	global_timer.stop()

func _process(delta: float) -> void:
	if increment_time and global_timer.is_stopped():
		global_timer.start()
	
func _on_global_timer_timeout():
	match timer_index:
		0:
			enemy_spawn_time.emit(phase1[0])
			global_timer.wait_time = 4.0
			global_timer.start()
		1:
			enemy_spawn_time.emit(phase1[1])
			global_timer.wait_time = 2.0
			global_timer.start()
		2:
			enemy_spawn_time.emit(phase1[2])
			global_timer.wait_time = 4.0
			global_timer.start()
		3:
			enemy_spawn_time.emit(phase1[3])
			enemy_spawn_time.emit(phase1[4])
			global_timer.wait_time = 2.0
			global_timer.start()
		4:
			enemy_spawn_time.emit(phase1[5])
			global_timer.wait_time = 2.0
			global_timer.start()
		5:
			enemy_spawn_time.emit(phase1[6])
			enemy_spawn_time.emit(phase1[7])
			global_timer.wait_time = 3.0
			global_timer.start()
		6:
			enemy_spawn_time.emit(phase1[8])
			global_timer.wait_time = 2.0
			global_timer.start()
		7:
			enemy_spawn_time.emit(phase1[9])
			enemy_spawn_time.emit(phase1[10])
			global_timer.wait_time = 1.0
			global_timer.start()
		8:
			enemy_spawn_time.emit(phase1[11])
			enemy_spawn_time.emit(phase1[12])
			global_timer.wait_time = 2.0
			global_timer.start()
			
		# PHASE II BEGINS
		9:
			enemy_spawn_time.emit(phase2[0])
			global_timer.wait_time = 2.0
			global_timer.start()
		10:
			enemy_spawn_time.emit(phase2[1])
			enemy_spawn_time.emit(phase2[2])
			global_timer.wait_time = 2.0
			global_timer.start()
		11:
			enemy_spawn_time.emit(phase2[3])
			enemy_spawn_time.emit(phase2[4])
			global_timer.wait_time = 3.0
			global_timer.start()
		12:
			enemy_spawn_time.emit(phase2[5])
			global_timer.wait_time = 1.0
			global_timer.start()
		13:
			enemy_spawn_time.emit(phase2[6])
			enemy_spawn_time.emit(phase2[7])
			global_timer.wait_time = 3.0
			global_timer.start()
		14:
			enemy_spawn_time.emit(phase2[8])
			enemy_spawn_time.emit(phase2[9])
			global_timer.wait_time = 2.0
			global_timer.start()
		15:
			enemy_spawn_time.emit(phase2[10])
			enemy_spawn_time.emit(phase2[11])
			global_timer.wait_time = 1.0
			global_timer.start()
		16:
			enemy_spawn_time.emit(phase2[12])
			global_timer.wait_time = 3.0
			global_timer.start()
		17:
			enemy_spawn_time.emit(phase2[13])
			global_timer.wait_time = 1.0
			global_timer.start()
		18:
			enemy_spawn_time.emit(phase2[14])
			final_enemy_spawned.emit()
	timer_index += 1
