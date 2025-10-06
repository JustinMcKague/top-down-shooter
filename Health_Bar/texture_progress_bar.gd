extends TextureProgressBar

func _process(delta: float) -> void:
	self.value = PlayerVariables.batteryCharge
	

func _on_timer_timeout() -> void:
	PlayerVariables.batteryCharge -= 3
