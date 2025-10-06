extends Node2D

var lasers_emitted: int = 0
@export var laser_emitters: Array[Node2D]

@export var laser: PackedScene

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	fire_laser()

func fire_laser():
	var laser_inst = laser.instantiate()
	laser_emitters[random_lane()].add_child(laser_inst)
	lasers_emitted += 1
	if lasers_emitted >= laser_emitters.size():
		lasers_emitted = 0
		$Delay.stop()
		return
	$Delay.start()

func random_lane() -> int:
	var random = rng.randi_range(0, 2)
	return random
	

func _on_delay_timeout() -> void:
	fire_laser()
