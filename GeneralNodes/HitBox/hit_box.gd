class_name HitBox extends Area2D

signal Damaged(hurt_box:HurtBox);

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass

func TakeDamage(hurt_box:HurtBox) -> void:
	print("Take Damage:",hurt_box)
	Damaged.emit(hurt_box)
