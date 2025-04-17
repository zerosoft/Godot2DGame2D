class_name EnemyState extends Node

var enemy:Enemy

var state_machine : EnemyStateMachine

func init()->void:
	pass

func enter()->void:
	# Called when the state is entered
	# This is where you can initialize any variables or perform any setup needed for the state
	pass
	
func exit()->void:  
	# Called when the state is exited
	# This is where you can clean up any resources or reset variables
	pass

func process(delta: float)->EnemyState:
	# Called every frame while the state is active
	# This is where you can perform any updates or checks needed for the state
	return null
	
func physics_process(delta: float)->EnemyState:
	# Called every physics frame while the state is active
	return null
