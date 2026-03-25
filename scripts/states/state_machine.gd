class_name StateMachine
extends RefCounted

var current_state : State
var default_state : State
var queue : Array[State] = []

func init(default_state: State):
	self.default_state = default_state
	transition_to(default_state)


func clear_queue(cancel_current_state := true) -> void:
	queue.clear()
	if cancel_current_state and current_state: 
		current_state.cancel()
		current_state = null


func enqueue(state: State) -> void:
	if state:
		queue.push_back(state)    
	if current_state: 
		return    
	transition_to(queue.pop_front())


func process(delta: float) -> void:
	if !current_state: 
		return
	current_state.process(delta)


func physics_process(delta: float) -> void:
	if !current_state: 
		return
	current_state.physics_process(delta)


func transition_to(state: State) -> void:
	if !state or state == current_state: 
		return
	if current_state:
		current_state.cancel()
	current_state = state
	if !current_state.exited.is_connected(on_state_exit):
		current_state.exited.connect(on_state_exit)
	current_state.enter()
	print("transitioned to " + str(current_state.get_script()))


func on_state_exit(state: State) -> void:
	print("exited " + str(current_state.get_script()))
	if queue.size() <= 0:
		transition_to(default_state)
		return
	transition_to(queue.pop_front())
