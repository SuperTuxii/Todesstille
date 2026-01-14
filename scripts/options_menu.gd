@tool
class_name OptionsMenu extends StyledPanel

var fps_counter_shown: bool = false

func _ready() -> void:
	super._ready()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		visible = false
	if fps_counter_shown:
		$"../FPSCounter".text = "FPS: " + str(Engine.get_frames_per_second())

func _on_back_button_pressed() -> void:
	visible = !visible


func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), value)

func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), value)

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX"), value)

func _on_fps_button_toggled(toggled_on: bool) -> void:
	fps_counter_shown = toggled_on
	$"../FPSCounter".visible = toggled_on 
