class_name Player extends CharacterBody2D

var carddinal_directions :Vector2 = Vector2.DOWN
var direction :Vector2 = Vector2.ZERO

var invulnerable :bool = false
var hp :int = 5
var max_hp :int = 5

@onready var animation_player :AnimationPlayer = $AnimationPlayer
@onready var effect_animation_player :AnimationPlayer = $EffectAnimationPlayer
@onready var sprite :Sprite2D = $Sprite2D
@onready var state_machine :PlayerStateMachine = $StateMachine
@onready var hit_box :HitBox = $HitBox

signal DirectionChanged(new_direction:Vector2)
signal player_damaged(hurt_box:HurtBox)

func _ready():
	PlayerManager.player = self
	state_machine.Initialize(self)
	hit_box.Damaged.connect(_take_damage)
	update_hp(5)
	pass


func _process(delta):
	
	# direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	# direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction = Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
		).normalized()
	pass

func SetDirection() -> bool:
	var new_direction :Vector2 = carddinal_directions
	if direction == Vector2.ZERO:
		return false
	
	# 确保只允许上下左右四个方向
	if abs(direction.x) > abs(direction.y):
		new_direction = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	else:
		new_direction = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	if new_direction == carddinal_directions:
		return false

	carddinal_directions = new_direction
	DirectionChanged.emit(new_direction)
	sprite.scale.x = -1 if carddinal_directions == Vector2.LEFT else 1

	return true


func AnimationDirection() -> String:
	if carddinal_directions == Vector2.DOWN:
		return "down"
	if carddinal_directions == Vector2.UP:
		return "up"
	if carddinal_directions == Vector2.ZERO:
		return "down"
	return "side"

func UpdateAnimation(state : String) -> void:
	var animation_name :String = state + "_" + AnimationDirection()
	animation_player.play(animation_name)
	pass

func _physics_process(delta: float) -> void:

	if abs(direction.x) > abs(direction.y):
		direction = Vector2(direction.x, 0).normalized()
	else:
		direction = Vector2(0, direction.y).normalized()
	
 	# 限制角色在地图边界内移动
	if LevelManager.current_titlemap_bounds!=null:
		var bounds :Array[Vector2] = LevelManager.current_titlemap_bounds
		if position.x < bounds[0].x:
			position.x = bounds[0].x
		elif position.x > bounds[1].x:
			position.x = bounds[1].x
		if position.y < bounds[0].y:
			position.y = bounds[0].y
		elif position.y > bounds[1].y:
			position.y = bounds[1].y

	move_and_slide()

func _take_damage(hurt_box:HurtBox) -> void:
	if invulnerable == true:
		return
	update_hp(-hurt_box.damage)
	
	if hp > 0:
		player_damaged.emit(hurt_box)
		return
	else:
		player_damaged.emit(hurt_box)
		update_hp(99)
		return

func update_hp(delta:int) -> void:
	hp = clampi(hp + delta, 0, max_hp)
	pass

func make_invulnerable(_duration:float=1.0) -> void:
	invulnerable = true
	hit_box.monitoring = false
	await get_tree().create_timer(_duration).timeout

	invulnerable = false
	hit_box.monitoring = true
	pass