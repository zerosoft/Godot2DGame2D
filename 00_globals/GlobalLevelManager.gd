extends Node

var current_titlemap_bounds :Array[Vector2] = []

signal TitleMapBoundsChanged(bounds :Array[Vector2])

func ChangeTitleMapBounds(bounds :Array[Vector2]) -> void:
	if bounds == current_titlemap_bounds:
		return
	current_titlemap_bounds = bounds
	TitleMapBoundsChanged.emit(bounds)
	pass
