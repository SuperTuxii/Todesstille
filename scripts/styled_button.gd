class_name StyledButton extends NinePatchRect

@export_category("Button")
@export_multiline
var text: String:
	set(value):
		button.text = value
	get:
		return button.text
@export
var icon: Texture2D:
	set(value):
		button.icon = icon
	get:
		return button.icon
@export
var disabled: bool:
	set(value):
		button.disabled = value
	get:
		return button.disabled
@export
var toggle_mode: bool:
	set(value):
		button.toggle_mode = value
	get:
		return button.toggle_mode

@onready
var button: Button = $Button

signal button_down
signal button_up
signal pressed
signal toggled(toggled_on: bool)

func _on_button_mouse_entered() -> void:
	pass # Replace with function body.

func _on_button_mouse_exited() -> void:
	pass # Replace with function body.

func _on_button_minimum_size_changed() -> void:
	pass # Replace with function body.


func _on_button_button_down() -> void:
	button_down.emit()
func _on_button_button_up() -> void:
	button_up.emit()
func _on_button_pressed() -> void:
	pressed.emit()
func _on_button_toggled(toggled_on: bool) -> void:
	toggled.emit(toggled_on)
