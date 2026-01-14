class_name TitleScreen extends Control

func _on_start_button_pressed() -> void:
	$TitleScreen.hide()
	$StartAnimation.show()
	$SkipButton.show()
	$StartAnimation.play()

func _on_options_button_pressed() -> void:
	$OptionsMenu.visible = !$OptionsMenu.visible

func _on_start_animation_animation_finished() -> void:
	get_tree().create_timer(1).timeout.connect(change_scene)

func _on_skip_button_pressed() -> void:
	change_scene()

func change_scene() -> void:
	if get_tree().current_scene is not Level:
		get_tree().change_scene_to_file("res://scenes/level.tscn")
