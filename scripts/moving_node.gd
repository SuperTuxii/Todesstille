class_name MovingNode extends Node2D

@export
var relative_movement: Vector2 = Vector2(1.0, 1.0)

@export
var time_movement: Vector2 = Vector2()

func _physics_process(delta: float) -> void:
	position += time_movement * delta

func relative_move(movement: Vector2) -> void:
	position += movement * relative_movement
