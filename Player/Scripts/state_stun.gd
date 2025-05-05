class_name State_Stun extends State

@export var knockback_speed: float = 200.0
@export var deceleration_speed : float = 10.0
@export var invulnerable_duration: float = 1.0

var hurt_box :HurtBox
var direction: Vector2

var next_state : State = null

@onready var idle : State = $"../Idle"

func init() -> void:
	player.player_damaged.connect(_player_damaged)

func Enter() -> void:
	player.UpdateAnimation("stun")
	player.animation_player.animation_finished.connect(_on_animation_finished)
	pass

func Exit() -> void:
	next_state = null
	player.animation_player.animation_finished.disconnect(_on_animation_finished)

	direction = player.global_position.direction_to(hurt_box.global_position)
	player.velocity=direction * -knockback_speed
	player.SetDirection()

	player.make_invulnerable(invulnerable_duration)
	player.effect_animation_player.play("damaged")
	pass

func Process(_delta:float) -> State:


	return next_state

func Physics(_delta:float) -> State:
	return self

func HandleInput(_event:InputEvent) -> State:
	return self

func _player_damaged(_hurt_box:HurtBox) ->void:
	hurt_box = _hurt_box
	state_machine.ChangeState(self)
	pass

func _on_animation_finished(_a:String) -> void:
	next_state = idle

	pass	