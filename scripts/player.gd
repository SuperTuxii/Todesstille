class_name Player extends CharacterBody2D

signal moved(difference: Vector2)

@onready
var texture: AnimatedSprite2D = $Texture
@onready
var timer: Timer = $Timer

const SPEED = 150.0
const JUMP_VELOCITY = -350.0

var inventory: Dictionary = {}
var speed_amplifier: float = 1.0:
	set(value):
		texture.speed_scale = value
		speed_amplifier = value
var jump_amplifier: float = 1.0

func standup() -> void:
	texture.play("standup")

func bury() -> void:
	texture.play_backwards("standup")

func idle() -> void:
	texture.play("idle")
	texture.sprite_frames.set_frame("idle", 0, texture.sprite_frames.get_frame_texture("idle", 0), randi_range(20, 50))
	if timer.is_stopped():
		timer.start(randf_range(50, 100))

func add_item(item_id: StringName, amount: int = 1):
	inventory[item_id] = inventory.get(item_id, 0) + amount
	if has_node("SeedCount") and item_id == "Seed":
		$SeedCount.text = str(inventory[item_id])
		if inventory[item_id] > 0:
			$UpgradeOverlay/HBoxContainer/StyledButton.show()

func remove_item(item_id: StringName, amount: int = 1):
	inventory[item_id] = inventory.get(item_id, 0) - amount
	if has_node("SeedCount") and item_id == "Seed":
		$SeedCount.text = str(inventory[item_id])

func _physics_process(delta: float) -> void:
	if not is_zero_approx(velocity.x):
		texture.play("walk")
	elif texture.animation == "walk":
		idle()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if texture.animation == "burried":
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("right") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left"):
			standup()
	elif texture.animation != "standup":
		# Handle jump.
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = JUMP_VELOCITY * jump_amplifier

		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED * speed_amplifier
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED * speed_amplifier)
	var prev_postion: Vector2 = position
	move_and_slide()
	
	if position != prev_postion:
		moved.emit(position - prev_postion)

func _on_texture_animation_finished() -> void:
	if texture.animation == "standup":
		if texture.frame != 0:
			idle()
		else:
			texture.play("burried")
	else:
		idle()

func _on_texture_animation_changed() -> void:
	if texture == null or timer == null:
		return
	if texture.animation != "idle":
		timer.stop()

func _on_timer_timeout() -> void:
	bury()
