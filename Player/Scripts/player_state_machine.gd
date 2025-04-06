class_name PlayerStateMachine extends Node

var state :Array[State]
var pre_state :State
var current_state :State


func _ready():
	process_mode = Node.ProcessMode.PROCESS_MODE_DISABLED
	pass

func _process(delta):
	ChangeState(current_state.Process(delta))
	pass

func _physics_process(delta):
	ChangeState(current_state.Physics(delta))
	pass


func _unhandled_input(event: InputEvent) -> void:
	ChangeState(current_state.HandleInput(event))
	pass

func Initialize(_player:Player)->void:
	state = []

	for s in get_children():
		if s is State:
			state.append(s)

	if state.size() > 0:
		state[0].player = _player
		ChangeState(state[0])
		process_mode = Node.PROCESS_MODE_INHERIT


func ChangeState(new_state:State) -> void:
	if  new_state == null || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()

	pre_state = current_state
	current_state = new_state
	current_state.Enter()
