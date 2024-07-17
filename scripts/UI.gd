extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_health_changed(health):
	$HPbar.value = health


func _on_player_died(life):
	if life == 3:
		$Heart_Img.texture = load("res://assets/textures/Heart_Orange_2.png")
	if life == 2:
		$Heart_Img.texture = load("res://assets/textures/Heart_Orange_3.png")
	if life == 1:
		$Heart_Img.texture = load("res://assets/textures/Heart_Orange_4.png")
	if life == 0:
		$Heart_Img.texture = null
		print("testing")


func _on_player_coins_changed(coins):
	$Coin_label.text = str(coins)
