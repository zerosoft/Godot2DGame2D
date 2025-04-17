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