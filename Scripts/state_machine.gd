extends Node
var current_state: State
var states: Dictionary = {}
@export var initial_state: State
func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		print(initial_state)
		initial_state.Enter()
		current_state = initial_state
		
func _process(delta):
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
		if current_state:
			current_state.Physics_Update(delta) 
			
func on_child_transition(state, new_state_name):
	if state != current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	if current_state:
		current_state.Exit()
	new_state.Enter()
	current_state = new_state


func _on_area_2d_body_entered(body: Node2D) -> void:
	on_child_transition(current_state, "Attack")


func _on_area_2d_body_exited(body: Node2D) -> void:
	on_child_transition(current_state, "Idle")
