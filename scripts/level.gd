class_name Level extends Node2D

@onready
var player: Player = $Player

func _ready() -> void:
	for child in get_children():
		if child is MovingNode:
			player.moved.connect(child.relative_move)
	player.standup()
