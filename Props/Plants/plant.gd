class_name Plant extends Node2D


func _ready() -> void:
	# print_tree()  # 打印场景树
	var hitbox=$HitBox
	if hitbox:
		print("HitBox is valid:", $HitBox)
		hitbox.Damaged.connect(TakeDamage)
	else:
		print("Node 'HitBox' not found!")
	pass
	
func TakeDamage(hurt_box:HurtBox)->void:
	queue_free()
	pass

func _process(delta: float) -> void:
	pass
