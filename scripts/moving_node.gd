class_name MovingNode extends Node2D

@export
var relative_movement: Vector2 = Vector2(1.0, 1.0)

@export
var time_movement: Vector2 = Vector2()

var material_children: Array = []

func _ready() -> void:
	for child in get_children():
		if child.material:
			material_children.append(child)

func _physics_process(delta: float) -> void:
	position += time_movement * delta
	for child in material_children:
		child.position -= time_movement * delta
		var scroll_offset: Vector2 = child.material.get_shader_parameter("offset")
		child.material.set_shader_parameter("offset", scroll_offset - (time_movement * delta))

func relative_move(movement: Vector2) -> void:
	position += movement * relative_movement
	for child in material_children:
		child.position -= (movement * relative_movement) - movement
		var scroll_offset: Vector2 = child.material.get_shader_parameter("offset")
		child.material.set_shader_parameter("offset", scroll_offset + (movement * relative_movement))
