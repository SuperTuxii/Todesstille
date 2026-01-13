@tool
class_name StyledPanel extends PanelContainer

@export
var margin: Vector2 = Vector2(0, 0):
	set(value):
		margin = value
		get_theme_stylebox("panel").content_margin_left = value.x
		get_theme_stylebox("panel").content_margin_right = value.x
		get_theme_stylebox("panel").content_margin_bottom = value.y
		get_theme_stylebox("panel").content_margin_top = value.y
@export
var color: Color = Color("80c230"):
	set(value):
		if has_node("NinePathRect"):
			$NinePathRect.material.set_shader_parameter("color", value)
		color = value
@export
var background_color: Color = Color("00000000"):
	set(value):
		get_theme_stylebox("panel").bg_color = value
		background_color = value

func _ready() -> void:
	$NinePathRect.material = $NinePathRect.material.duplicate()
	$NinePathRect.material.set_shader_parameter("color", color)
	add_theme_stylebox_override("panel", get_theme_stylebox("panel"))
	get_theme_stylebox("panel").bg_color = background_color
	get_theme_stylebox("panel").content_margin_left = margin.x
	get_theme_stylebox("panel").content_margin_right = margin.x
	get_theme_stylebox("panel").content_margin_bottom = margin.y
	get_theme_stylebox("panel").content_margin_top = margin.y
