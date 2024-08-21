extends CharacterBody2D


const GRAVITY = 3800.0
const JUMP_SPEED = -1500.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
# var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	velocity.y += GRAVITY * delta
	if is_on_floor():
		if Input.is_action_pressed("ui_accept"):
			velocity.y = JUMP_SPEED
		else:  
			$AnimatedSprite2D.play("Running")
		

	move_and_slide()
