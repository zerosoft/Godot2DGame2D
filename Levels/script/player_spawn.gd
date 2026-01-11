extends Node2D

func _ready():
	visible = false
	if PlayerManager.player_spawn == false:
		print("Player Spawn at:",global_position)
		PlayerManager.set_player_position(global_position)
		PlayerManager.player_spawn = true