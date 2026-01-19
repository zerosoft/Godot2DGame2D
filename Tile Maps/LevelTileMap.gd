class_name LevelTileMap extends TileMapLayer

func _ready() -> void:
	LevelManager.change_titleMap_bounds(GetTileMapBounds())
	pass

func GetTileMapBounds() -> Array[Vector2]:
	var bounds :Array[Vector2] = []
	bounds.append(Vector2(get_used_rect().position * rendering_quadrant_size*2))

	bounds.append(Vector2(get_used_rect().end * rendering_quadrant_size*2))
	
	return bounds
