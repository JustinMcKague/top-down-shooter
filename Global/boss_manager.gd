extends Node

enum BossAttack {
	SPRAY,
	LASER,
	WAVE,
	REINFORCE
}

var time_elapsed = 0

signal attack(attack_type: BossAttack)

var alive: bool = true

var boss_timer: Timer
var timer_index: int = -1

func _ready() -> void:
	boss_timer = Timer.new()
	add_child(boss_timer)
	boss_timer.wait_time = 5.0
	boss_timer.one_shot = false
	boss_timer.autostart = false
	boss_timer.connect("timeout", _on_boss_timer_timeout)

func _process(delta: float) -> void:
	if FlowManager.increment_time and boss_timer.is_stopped():
		boss_timer.start()

func _on_boss_timer_timeout():
	match timer_index:
		0:
			attack.emit(BossAttack.SPRAY)
			boss_timer.wait_time = 5.0
			boss_timer.start()
		1:
			attack.emit(BossAttack.LASER)
			boss_timer.wait_time = 6.0
			boss_timer.start()
		2:
			attack.emit(BossAttack.REINFORCE)
			boss_timer.wait_time = 1.0
			boss_timer.start()
		3:
			attack.emit(BossAttack.WAVE)
			boss_timer.wait_time = 4.0
			boss_timer.start()
		4:
			attack.emit(BossAttack.LASER)
			boss_timer.wait_time = 1.0
			boss_timer.start()
		5:
			attack.emit(BossAttack.REINFORCE)
			boss_timer.wait_time = 5.0
			boss_timer.start()
		6:
			attack.emit(BossAttack.SPRAY)
			boss_timer.wait_time = 5.0
			boss_timer.start()
		7:
			attack.emit(BossAttack.WAVE)
			boss_timer.wait_time = 1.0
			boss_timer.start()
		8:
			attack.emit(BossAttack.REINFORCE)
			boss_timer.wait_time = 3.0
			boss_timer.start()
		9:
			attack.emit(BossAttack.LASER)
			boss_timer.wait_time = 6.0
			boss_timer.start()
		10:
			attack.emit(BossAttack.SPRAY)
			boss_timer.wait_time = 1.0
			boss_timer.start()
		11:
			attack.emit(BossAttack.REINFORCE)
			boss_timer.wait_time = 4.0
			boss_timer.start()
		12:
			attack.emit(BossAttack.WAVE)
			boss_timer.wait_time = 4.0
			boss_timer.start()
		13:
			attack.emit(BossAttack.LASER)
			boss_timer.wait_time = 1.0
			boss_timer.start()
		14:
			attack.emit(BossAttack.REINFORCE)
			boss_timer.wait_time = 5.0
			boss_timer.start()
		15:
			attack.emit(BossAttack.SPRAY)
			boss_timer.wait_time = 5.0
			boss_timer.start()
		16:
			attack.emit(BossAttack.WAVE)
	timer_index += 1
