class_name EnemyStateStun extends EnemyState

@export var anim_name: String = "stun"
@export var knockback_speed: float = 200.0
@export var deceleration_speed : float = 10.0

@export_category("AI")

@export var next_state : EnemyState = null

var _danage_postion: Vector2
var _direction: Vector2
var _animation_finished: bool = false

func init()->void:
	enemy.enemy_damaged.connect(_on_enemy_damaged)
	pass

func enter()->void:
	enemy.invulnerable = true

	_animation_finished = false
	
	# 计算被攻击的方向
	_direction = enemy.global_position.direction_to(_danage_postion)
	
	# 设置敌人远离攻击方向 10 像素
	enemy.global_position -= _direction * 20

	# 设置敌人的方向和速度
	enemy.set_direction(_direction)
	enemy.velocity = _direction * knockback_speed

	# 播放击退动画
	enemy.UpdateAnimation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass
	
func exit()->void:  
	enemy.invulnerable=false
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass

func process(_delta: float)->EnemyState:
	if _animation_finished == true:
		return next_state
	enemy.velocity -= enemy.velocity*deceleration_speed*_delta
	return null
	
func physics_process(delta: float)->EnemyState:
	# Called every physics frame while the state is active
	return null

func _on_enemy_damaged(hurt_box:HurtBox)->void:
	print("enemy damaged stun")
	_danage_postion = hurt_box.global_position
	state_machine.change_state(self)
	pass

func _on_animation_finished(_a:String):
	_animation_finished = true
	# enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	pass