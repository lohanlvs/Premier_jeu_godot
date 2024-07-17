extends CharacterBody2D

var speed = 50
var direction = Vector2.RIGHT
var HP = 500

@onready var ray_cast = $RayCast2D
@onready var ray_right : RayCast2D = $LedgeCheckRight
@onready var ap : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var player = get_parent().find_child("Player") 

func _ready():
	ap.play("idle")
	velocity = direction * speed
	move_and_slide()
	set_physics_process(false)

func _process(delta):
	direction= (player.position - global_position).normalized()
	ray_cast.target_position = direction * 100

func take_damage(dmg):
	HP = HP - dmg
	if HP <= 0:
		self.queue_free()


func _physics_process(delta):
	ap.play("idle")
	

