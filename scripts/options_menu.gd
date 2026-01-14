@tool
class_name OptionsMenu extends StyledPanel

func _ready() -> void:
	super._ready()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		visible = false

func _on_back_button_pressed() -> void:
	visible = !visible
