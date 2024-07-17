extends CharacterBody2D

var speed = 50
var direction = Vector2.RIGHT

@onready var ray_left : RayCast2D = $LedgeCheckLeft
@onready var ray_right : RayCast2D = $LedgeCheckRight
@onready var ap : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D

func take_damage():
	self.queue_free()


func _physics_process(delta):
	var found_wall = is_on_wall()
	var found_ledge = !ray_right.is_colliding() or !ray_left.is_colliding()

	if found_wall or found_ledge:
		direction *= -1
		velocity = direction * speed
		ap.play("walking")
		sprite.flip_h = direction == Vector2.LEFT  
	
	# Move the enemy
	velocity = direction * speed
	move_and_slide()
