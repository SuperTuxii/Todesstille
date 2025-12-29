class_name Player extends CharacterBody2D

signal moved(difference: Vector2)

@onready
var texture: AnimatedSprite2D = $Texture

const SPEED = 150.0
const JUMP_VELOCITY = -350.0

var inventory: Dictionary = {}

func standup() -> void:
	texture.play("standup")

func add_item(item_id: StringName):
	inventory[item_id] = inventory.get(item_id, 0) + 1
	if has_node("InventoryOverlay/Label") and item_id == "Seed":
		$InventoryOverlay/Label.text = str(inventory[item_id])

func _physics_process(delta: float) -> void:
	if not is_zero_approx(velocity.x):
		texture.play("walk")
	elif texture.animation != "standup":
		texture.play("idle")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if texture.animation != "standup":
		# Handle jump.
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	var prev_postion: Vector2 = position
	move_and_slide()
	
	if position != prev_postion:
		moved.emit(position - prev_postion)

func _on_texture_animation_finished() -> void:
	if texture.animation == "standup":
		texture.play("idle")
