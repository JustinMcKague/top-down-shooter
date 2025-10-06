extends Node2D

@export var missile: PackedScene

var width

var spawn_points: Array[float]

var number_of_spawns: int = 10

var rng = RandomNumberGenerator.new()

var missiles_spawned = 0

var left_to_right

func _ready() -> void:
	width = get_viewport().get_visible_rect().size.x
	spawn_points = []
	for i in number_of_spawns:
		var adjusted = width - (i * 48) - 240
		spawn_points.append(adjusted)
	prep_wave()
		
func prep_wave():
	firing_left_right()
	fire_wave()
	$Delay.start()

func fire_wave():
	var missile_inst = missile.instantiate()
	self.add_child(missile_inst)
	if left_to_right == 1:
		missile_inst.position = Vector2(spawn_points[missiles_spawned], 0)
		missiles_spawned += 1
		if missiles_spawned >= number_of_spawns - 1:
			$Delay.stop()
	else:
		missile_inst.position = Vector2(spawn_points[missiles_spawned], 0)
		missiles_spawned -= 1
		if missiles_spawned <= 1:
			$Delay.stop()

func firing_left_right() -> bool:
	var value = rng.randi_range(0, 1)
	if value == 0:
		missiles_spawned = 9
	else:
		missiles_spawned = 0
	left_to_right = value
	return value

func _on_delay_timeout() -> void:
	fire_wave()
