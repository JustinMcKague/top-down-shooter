extends Area2D

func _ready() -> void:
	rotate(-0.1)
func _process(delta: float) -> void:
	move_local_y(3)
