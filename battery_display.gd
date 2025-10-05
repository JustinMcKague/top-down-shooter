extends ColorRect

var original_size

var current_size

func _ready() -> void:
	original_size = self.size.y
	update_battery_display()

func update_battery_display():
	current_size = original_size * (PlayerVariables.batteryCharge / 100.0)
	self.size.y = current_size
