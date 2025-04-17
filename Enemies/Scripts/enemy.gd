class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction:Vector2)
signal animation_damaged()

const DIR_4 = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

@export var hp :int = 5

var carddinal_directions :Vector2 = Vector2.DOWN
var direction :Vector2 = Vector2.ZERO
var player:Player
var invulnerable :bool = false

@onready var animation_player :AnimationPlayer = $AnimationPlayer
@onready var sprite :Sprite2D = $Sprite2D
# @onready var hitbox :Area2D = $Hitbox
@onready var state_machine :EnemyStateMachine = $EnemyStateMachine

func _ready():
	state_machine.Initialize(self)
	player=PlayerManager.player 
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()

func set_direction(_direction :Vector2):
	direction=_direction;

func SetDirection() -> bool:
	var new_direction :Vector2 = carddinal_directions
	if direction == Vector2.ZERO:
		return false
	
	var direction_id:int = int(
	  round(
		(direction+carddinal_directions*0.1).angle()/TAU*DIR_4.size()
	  )
	)

	var new_dir=DIR_4[direction_id]

	if new_dir == carddinal_directions:
		return false
	# 确保只允许上下左右四个方向
	carddinal_directions = new_dir

	direction_changed.emit(new_dir)
	
	sprite.scale.x = -1 if carddinal_directions == Vector2.LEFT else 1

	return true

func UpdateAnimation(state : String) -> void:
	var animation_name :String = state + "_" + AnimationDirection()
	animation_player.play(animation_name)
	pass

func AnimationDirection() -> String:
	if carddinal_directions == Vector2.DOWN:
		return "down"
	if carddinal_directions == Vector2.UP:
		return "up"
	if carddinal_directions == Vector2.ZERO:
		return "down"
	return "side"
