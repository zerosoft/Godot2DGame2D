class_name HitBox extends Area2D

signal Damaged(damage:int);

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func TakeDamage(damage:int) -> void:
	print("Take Damage:",damage)
	Damaged.emit(damage)
