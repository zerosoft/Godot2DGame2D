class_name State_Idle extends State

@onready var walk : State = $"../Walk"
@onready var attack : State = $"../Attack"

func Enter() -> void:
    player.UpdateAnimation("idle")
    pass

func Exit() -> void:
    pass

func Process(_delta:float) -> State:
    if player.direction != Vector2.ZERO:
        return walk
    player.velocity = Vector2.ZERO
    return self

func Physics(_delta:float) -> State:
    return self

func HandleInput(_event:InputEvent) -> State:
    if _event.is_action_pressed("attack"):
        return attack
    return self