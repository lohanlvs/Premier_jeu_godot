extends CharacterBody2D


signal health_changed(health)
signal died(life)
signal coins_changed(coins)

const SPEED = 350.0
const JUMP_VELOCITY = -400.0
@onready var ap = $AnimationPlayer
@onready var sprite =$Sprite2D

var is_dead = false
var life = 4
var HP = 100
var coins = 0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_key_pressed(KEY_K):
		$Area2D/CollisionShape2D.disabled = false
		ap.play("attack2")
	else:
		$Area2D/CollisionShape2D.disabled = true

func _physics_process(delta):
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
	if is_on_floor() and !Input.is_key_pressed(KEY_K):
		if direction == 0 :
			ap.play("idle")
		else:
			ap.play("run")
	else:
		if velocity.y < 0:
			ap.play("jump")
		elif velocity.y > 0:
			ap.play("fall")

func death():
	position.x=51
	position.y=94
	life = life-1
	print(life)
	died.emit(life)
	HP = 100
	health_changed.emit(100)
	is_dead = true
	if life <= 0:
		self.queue_free()

func dmg_taken(dmg):
	HP = HP - dmg
	health_changed.emit(HP)
	if HP <= 0:
		death()
		is_dead = false

func get_coins(nbmr_coins):
	coins = coins + nbmr_coins
	coins_changed.emit(coins)
	print(coins)


	

func _on_area_2d_body_entered(body):
	if body.is_in_group("Hit"):
		body.take_damage()
	if body.is_in_group("Test"):
		body.take_damage(50)
	else:
		pass
	 # Replace with function body.
