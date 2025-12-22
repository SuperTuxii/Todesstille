class_name Level extends Node2D

@onready
var player: Player = $Player

func _ready() -> void:
	player.standup()
