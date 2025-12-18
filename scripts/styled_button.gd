@tool
class_name StyledButton extends NinePatchRect

@export_multiline
var text: String:
	set(value):
		$Button.text = value
	get:
		return $Button.text
@export
var icon: Texture2D:
	set(value):
		$Button.icon = icon
	get:
		return $Button.icon
@export
var disabled: bool:
	set(value):
		$Button.disabled = value
	get:
		return $Button.disabled
@export
var toggle_mode: bool:
	set(value):
		$Button.toggle_mode = value
	get:
		return $Button.toggle_mode
@export
var font_size: int = 9:
	set(value):
		$Button.add_theme_font_size_override("font_size", value)
	get:
		return $Button.get_theme_font_size("font_size")
@export
var margin: Vector2 = Vector2(15, 10):
	set(value):
		margin = value
		_on_button_minimum_size_changed()
@export
var minimum_size: Vector2:
	set(value):
		minimum_size = value
		_on_button_minimum_size_changed()
@export_group("Colors")
@export
var color: Color = Color.GRAY:
	set(value):
		$Button.add_theme_color_override("font_color", value)
		$Button.add_theme_color_override("font_focus_color", value)
		color = value
@export
var hover_color: Color = Color.WHITE:
	set(value):
		$Button.add_theme_color_override("font_hover_color", value)
		hover_color = value
@export
var pressed_color: Color = Color.DIM_GRAY:
	set(value):
		$Button.add_theme_color_override("font_pressed_color", value)
		$Button.add_theme_color_override("font_hover_pressed_color", value)
		pressed_color = value

signal button_down
signal button_up
signal pressed
signal toggled(toggled_on: bool)

func _ready() -> void:
	material = material.duplicate()

func set_color(p_color: Color):
	material.set_shader_parameter("color", p_color)

func _on_button_mouse_entered() -> void:
	if !$Button.button_pressed:
		set_color(hover_color)

func _on_button_mouse_exited() -> void:
	set_color(pressed_color if $Button.button_pressed else color)

func _on_button_minimum_size_changed() -> void:
	if has_node("Button") and $Button.is_node_ready():
		custom_minimum_size = Vector2(max($Button.get_minimum_size().x + margin.x, minimum_size.x), max($Button.get_minimum_size().y + margin.y, minimum_size.y))

func _on_button_button_down() -> void:
	button_down.emit()
	set_color(pressed_color)
func _on_button_button_up() -> void:
	button_up.emit()
	set_color(hover_color if $Button.is_hovered() else color)
func _on_button_pressed() -> void:
	pressed.emit()
func _on_button_toggled(toggled_on: bool) -> void:
	toggled.emit(toggled_on)
