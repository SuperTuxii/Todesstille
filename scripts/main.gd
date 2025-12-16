class_name TitleScreen extends Control

func _on_start_button_pressed() -> void:
	$TitleScreen.hide()
	$StartAnimation.show()
	$StartAnimation/PlantGrow.play()

func _on_options_button_pressed() -> void:
	pass # TODO: Add Options

func _on_plant_grow_animation_finished() -> void:
	get_tree().create_timer(0.5, false).timeout.connect($StartAnimation/WindBlow.play)
