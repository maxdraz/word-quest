class_name CameraBase
extends Node3D

@export var camera: Camera3D
@export var noise_speed: float = 20.0
@export var shake_decay: float = 5.0
@export var smoothing: float = 5.0
@export var min_shake_intensity : float

var noise := FastNoiseLite.new()
var time: float = 0.0
var shake_strength: float

func _ready():
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 0.1
	if min_shake_intensity > 0:
		shake(min_shake_intensity)


func _process(delta):
	time += delta * noise_speed

	shake_strength = lerp(shake_strength, min_shake_intensity, shake_decay * delta)

	var offset := Vector3(
		noise.get_noise_2d(time, 0.0),
		noise.get_noise_2d(0.0, time),
		0
	) * shake_strength

	camera.position = camera.position.lerp(offset, smoothing * delta)



func shake(intensity: float):
	shake_strength = max(shake_strength, intensity)