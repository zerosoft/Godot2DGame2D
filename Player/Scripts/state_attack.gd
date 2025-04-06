class_name State_Attack extends State

var attacking:bool = false

@export var attack_sound :AudioStream
@export_range(1,20,0.5) var deceleration:float = 5.0


@onready var idle : State = $"../Attack"
@onready var walk : State = $"../Walk"

@onready var animation_player :AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_anim :AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var audio :AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_anim.play("attack_"+player.AnimationDirection())
	animation_player.animation_finished.connect(EndAttack)

	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()

	attacking = true
	pass

func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)


	attacking = false
	pass

func Process(_delta:float) -> State:
	player.velocity -= player.velocity * deceleration * _delta
	if attacking == false:
		if player.direction != Vector2.ZERO:
			return idle
		else:
			return walk
	return null

func Physics(_delta:float) -> State:
	return self

func HandleInput(_event:InputEvent) -> State:
	return self

func EndAttack( _newAnimName:String) -> void:
	attacking = false
	pass
