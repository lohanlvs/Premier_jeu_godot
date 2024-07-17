extends CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -400.0
@onready var ap = $AnimationPlayer
@onready var sprite =$Sprite2D
@onready var cam = $Camera2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _enter_tree():
	set_multiplayer_authority(name.to_int())

func _physics_process(delta):
	if is_multiplayer_authority():
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if direction !=0:
			sprite.flip_h = (direction == -1)
		move_and_slide()
		update_animation(direction)
	
func update_animation(direction):
	if is_on_floor():
		if direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else :
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")
