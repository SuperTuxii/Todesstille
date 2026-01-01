extends Label

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("upgrade_menu"):
		toggle_upgrade_menu()

func toggle_upgrade_menu() -> void:
	visible = !visible
	get_tree().paused = visible

func _on_seed_count_pressed() -> void:
	toggle_upgrade_menu()

func _on_styled_button_pressed() -> void:
	toggle_upgrade_menu()
	$HBoxContainer/StyledButton.hide()
	get_parent().remove_item("Seed")
	get_parent().speed_amplifier *= 1.15
	$AnimationPlayer.play("upgrade")
