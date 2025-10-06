extends TextureProgressBar

var is_decreasing: bool = false

func _process(delta: float) -> void:
	self.value = PlayerVariables.batteryCharge

func _on_timer_timeout() -> void:
	if PlayerVariables.battery_decaying == true:
		PlayerVariables.batteryCharge -= 2
