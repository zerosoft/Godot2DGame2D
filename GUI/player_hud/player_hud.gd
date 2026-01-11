extends CanvasLayer

var hearts:Array[HeartGUI] = []

func _ready() -> void:
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI:
			hearts.append(child)
			child.set_visible(false)
	pass

func update_hp(health:int,_max_hp:int) -> void:
	print("Update HP HUD:",health,"/",_max_hp)
	update_max_hp(_max_hp)
	for i in _max_hp:
		update_heart(i, health)
	pass

func update_heart(health:int,_max_hp:int) -> void:
	var _value:int = clamp(_max_hp - health*2, 0, 2)
	hearts[health].value = _value
	pass

func update_max_hp(_max_hp:int) -> void:
	var _heart_count:int = round(_max_hp / 2)
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].set_visible(true)
		else:
			hearts[i].set_visible(false)
	pass
