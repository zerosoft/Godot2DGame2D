class_name State extends Node

static var player:Player
static var state_machine:PlayerStateMachine

func _ready() -> void:
	pass

func init() -> void:
	pass

func Enter() -> void:
	pass


func Exit() -> void:
	pass

func Process(_delta:float) -> State:
	return self

func Physics(_delta:float) -> State:
	return self

func HandleInput(_event:InputEvent) -> State:
	return self
