@tool
class_name Item extends Area2D

@export
var item_id: StringName

@export
var texture: Texture2D:
	get:
		return $Sprite2D.texture
	set(value):
		$Sprite2D.texture = value

@export
var levitation_height: float = 0.0
@export
var levitation_speed: float = 1.0
@export
var levitation_range: float = 8.0
var levitation_time: float = 0.0

func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		levitation_time += delta
		if levitation_time > (1 / levitation_speed):
			levitation_time -= 2 / levitation_speed
		position.y = lerp(levitation_height, levitation_height + levitation_range, abs(levitation_time) * levitation_speed)

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.add_item(item_id)
		queue_free()
