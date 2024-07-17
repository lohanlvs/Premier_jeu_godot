extends Node2D

var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
@onready var cam = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_join_pressed():
	peer.create_client("127.0.0.1", 123)
	multiplayer.multiplayer_peer = peer
	get_node("Join").queue_free()
	get_node("Host").queue_free()

func _on_host_pressed():
	peer.create_server(123)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player()
	get_node("Host").queue_free()
	get_node("Join").queue_free()


func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)
	
func exit_game(id):
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)
	
func del_player(id):
	rpc("_del_player", id)
	
@rpc("any_peer", "call_local") func _del_player(id):
	get_node(str(id)).queue_free()


func _on_area_2d_body_entered(body):
	get_tree().change_scene_to_file("res://scenes/ui_fin_multi.tscn")
