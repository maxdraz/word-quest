class_name MoveToState
extends State

var params : MoveToStateParams
var start_basis : Basis
var target_basis : Basis
var start_position : Vector3
var rotation_progress : float
var movement_progress : float


func init(params: MoveToStateParams) -> void:
	self.params = params	


func enter() -> void:
	super.enter()
	start_position = params.character.global_position
	start_basis = params.character.basis
	var look_dir = start_position.direction_to(params.target_position)
	target_basis = params.character.transform.looking_at(params.character.global_position - look_dir).basis
	movement_progress = 0
	rotation_progress = 0
	params.character.animation_tree.set("parameters/Run/blend_position", params.character.fighting_style)
	params.character.animation_state_machine.travel("Run")


func physics_process(delta) -> void:
	# rotation
	rotation_progress += delta / params.rotation_duration
	if !rotation_progress > 1:
		var rotation_progress_eased =  ease(rotation_progress, -1)
		params.character.basis = start_basis.slerp(target_basis, rotation_progress_eased)
	#movement
	movement_progress += delta / params.move_duration
	var movement_progress_eased =  ease(movement_progress, -2)
	var arrive_offset = start_position.direction_to(params.target_position) * params.stopping_distance
	params.character.global_position = start_position.lerp(params.target_position - arrive_offset, movement_progress_eased)
	if movement_progress >= 0.95:
		exit()
