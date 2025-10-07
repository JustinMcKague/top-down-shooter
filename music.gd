extends AudioStreamPlayer2D

@export var standard_music: AudioStream
@export var boss_music: AudioStream

func _ready() -> void:
	BossManager.boss_spawned.connect(_on_boss_spawn)
	PlayerVariables.restart.connect(_on_restart)
	
func _on_boss_spawn():
	self.stream = boss_music

func _on_restart():
	self.stream = standard_music
