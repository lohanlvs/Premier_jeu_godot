extends Area2D

@onready var ap : AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ap.play("Coin_Ani")


func _on_body_entered(body):
	if body.name=="Player":
		body.get_coins(1)
		self.queue_free()
