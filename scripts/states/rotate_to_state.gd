class_name RotateToState
extends State

var to_rotate : Node3D
var look_dir : Vector3


func init(to_rotate: Node3D, look_dir: Vector3) -> void:
	self.to_rotate = to_rotate
	self.look_dir = look_dir


func physics_process(delta) -> void:
	super.physics_process(delta)
	
	var target_basis = to_rotate.transform.looking_at(to_rotate.global_position + look_dir).basis
	to_rotate.basis = to_rotate.basis.slerp(target_basis, 10 * delta)
	print("rotating")
	if to_rotate.basis.is_equal_approx(target_basis):
		exit()
