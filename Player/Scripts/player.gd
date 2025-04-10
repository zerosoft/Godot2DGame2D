class_name Player extends CharacterBody2D

var carddinal_directions :Vector2 = Vector2.DOWN
var direction :Vector2 = Vector2.ZERO

@onready var animation_player :AnimationPlayer = $AnimationPlayer
@onready var sprite :Sprite2D = $Sprite2D
@onready var state_machine :PlayerStateMachine = $StateMachine

signal DirectionChanged(new_direction:Vector2)

func _ready():
	state_machine.Initialize(self)
	pass


func _process(delta):
	
	# direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	# direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	direction = Vector2(
		Input.get_axis("move_left","move_right"),
		Input.get_axis("move_up","move_down")
		).normalized()
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()


func SetDirection() -> bool:
	var new_direction :Vector2 = carddinal_directions
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_direction=Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x == 0:
		new_direction=Vector2.UP if direction.y < 0 else Vector2.DOWN
	
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
