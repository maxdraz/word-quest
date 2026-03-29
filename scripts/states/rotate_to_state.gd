class_name RotateToState
extends State


var params : RotateToStateParams
var start_basis : Basis
var target_basis : Basis
var progress : float


func init(params: RotateToStateParams) -> void:
	self.params = params


func enter() -> void:
	super.enter()
	start_basis = params.to_rotate.basis
	target_basis = params.to_rotate.transform.looking_at(params.to_rotate.global_position + params.look_dir).basis
	progress = 0


func physics_process(delta) -> void:
	super.physics_process(delta)
	progress += delta / params.duration
	var progress_eased =  ease(progress, -2)
	params.to_rotate.basis = start_basis.slerp(target_basis, progress_eased)
	if progress >= 1:
		exit()
