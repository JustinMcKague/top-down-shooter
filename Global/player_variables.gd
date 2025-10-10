extends Node

@export var batteryCharge: int = 100

@export var playerSpeed: float = 1.0

@export var playerFireRate: float = 0.25

@export var playerHealth: int = 10

var can_fire: bool = false

var battery_decaying: bool = false

var read_preamble: bool = false

signal player_death(diaType: DialogueGlobal.DialogueType)
signal game_over

signal restart

signal win
