class_name EnemyStateWalk extends EnemyState

@export var anim_name: String = "walk"
@export var walk_speed: float = 100.0

@export_category("AI")

@export var state_animation_duration : float = 0.5
@export var state_cycle_min : int = 1
@export var state_cycle_max : int = 3
@export var next_state : EnemyState = null

var _timer: float = 0.0
var _direction: Vector2

func init()->void:
	pass

func enter()->void:
	_timer = randf_range(state_cycle_min, state_cycle_max) * state_animation_duration
	var rand=randi_range(0,3)
	_direction=enemy.DIR_4[rand]
	enemy.velocity = _direction * walk_speed

	# 限制角色在地图边界内移动
	if LevelManager.current_titlemap_bounds!=null:
		var bounds :Array[Vector2] = LevelManager.current_titlemap_bounds
		if enemy.velocity.x < bounds[0].x:
			enemy.velocity.x = bounds[0].x
		elif enemy.velocity.x > bounds[1].x:
			enemy.velocity.x = bounds[1].x
		if enemy.velocity.y < bounds[0].y:
			enemy.velocity.y = bounds[0].y
		elif enemy.velocity.y > bounds[1].y:
			enemy.velocity.y = bounds[1].y

	enemy.set_direction(_direction)
	
	enemy.UpdateAnimation(anim_name)
	pass
	
func exit()->void:  
	# Called when the state is exited
	# This is where you can clean up any resources or reset variables
	pass

func process(_delta: float)->EnemyState:
	_timer-=_delta
	if _timer<=0:
		return next_state
	return null
	
func physics_process(delta: float)->EnemyState:
	# Called every physics frame while the state is active
	return null
