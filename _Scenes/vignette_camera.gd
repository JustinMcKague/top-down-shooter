extends Node2D

@export var vignette: ColorRect

func _ready() -> void:
	var _material = vignette.material
	
	if _material is ShaderMaterial:
		var shader = _material
		update_blindness(shader)

func update_blindness(shader):
	shader.set_shader_parameter('radius', PlayerVariables.batteryCharge / 100.0) # sets the radius of the vignette equal to the battery percent
