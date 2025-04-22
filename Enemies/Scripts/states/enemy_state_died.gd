class_name EnemyStateDied extends EnemyState

@export var anim_name: String = "destroy"
@export var knockback_speed: float = 200.0
@export var deceleration_speed : float = 10.0

@export_category("AI")

var _direction: Vector2


func init()->void:
	enemy.enemy_died.connect(_on_enemy_destroy)
	pass

func enter()->void:
	enemy.invulnerable=true
	
	_direction=enemy.global_position.direction_to(enemy.player.global_position)
	
	enemy.set_direction(_direction)
	enemy.velocity = _direction * knockback_speed

	enemy.UpdateAnimation(anim_name)
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	pass
	
func exit()->void:  
	pass

func process(_delta: float)->EnemyState:
	enemy.velocity -= enemy.velocity*deceleration_speed*_delta
	return null
	
func physics_process(delta: float)->EnemyState:
	# Called every physics frame while the state is active
	return null

func _on_enemy_destroy():
	state_machine.change_state(self)
	pass

func _on_animation_finished(_a:String):
	enemy.queue_free()
	pass