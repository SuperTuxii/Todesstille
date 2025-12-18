class_name TitleScreen extends Control

func _on_start_button_pressed() -> void:
	$TitleScreen.hide()
	$StartAnimation.show()
	$StartAnimation.play()

func _on_options_button_pressed() -> void:
	pass # TODO: Add Options
