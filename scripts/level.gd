class_name Level extends Node2D

@onready
var player: Player = $Player
@onready
var point_light: PointLight2D = $Player/PointLight2D

func _ready() -> void:
	for child in get_children():
		if child is MovingNode:
			player.moved.connect(child.relative_move)
	player.standup()

func _process(delta: float) -> void:
	point_light.energy += (-1.5 if player_safe else 0.75) * delta
	point_light.energy = clamp(point_light.energy, 0.0, 2.5)
	if point_light.energy >= 2.49:
		point_light.energy = 0.0
		$Player/DeathOverlay.show()
		get_tree().paused = true

var player_safe: bool = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player_safe = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		player_safe = false

func _on_retry_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/level.tscn")
