extends TextureProgressBar

func _process(delta: float) -> void:
	self.value = Global.playerHealth
	
