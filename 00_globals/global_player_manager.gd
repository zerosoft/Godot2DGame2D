extends Node

const PLAYER = preload("res://Player/player.tscn")

var player : Player
var player_spawn : bool = false

func _ready()->void:
	add_player_instance()
	await get_tree().create_timer(0.5).timeout
	player_spawn = true

func add_player_instance()->void:
	player = PLAYER.instantiate()
	add_child(player)

func set_player_position(position:Vector2)->void:
	player.global_position = position

func set_as_parent(_p:Node2D)->void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	_p.add_child(player)

func unparent_player(_player_node:Node2D)->void:
	_player_node.remove_child(player)
