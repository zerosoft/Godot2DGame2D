class_name HurtBox extends Area2D

@export var damage : int = 1


func _ready():
	print("HurtBox ready")
	# print_tree_pretty()  # 打印完整场景树
	area_entered.connect(AreaEntered)
	
func AreaEntered(a: Area2D) -> void:
	print("Area Entered:", a)
	if a is HitBox:
		print("HitBox detected!")
		a.TakeDamage(self)
	else:
		print("Not a HitBox:", a)
