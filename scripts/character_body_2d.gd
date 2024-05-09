extends CharacterBody2D

var jump_count = 0

const SPEED = 300.0
const JUMP_VELOCITY = -450.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if Input.is_action_just_pressed("Secret"):
		if position.x > 640:
			velocity.y = -800
			velocity.x = -3000
		else:
			velocity.y = -800
			velocity.x = +3000
	
	if velocity.y > 3250:
		velocity.y = 3250
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if is_on_floor():
		jump_count = 0
		
	# Handle Jump.
	if (Input.is_action_just_pressed("MoveUp")) and jump_count <= 1:
		jump_count += 1
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
