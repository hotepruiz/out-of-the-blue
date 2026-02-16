extends Node3D
class_name CameraRig

@export var Height : float
@export var _Player : Player
@export var _InputSystem: InputSystem;

func _process(delta: float) -> void:
	_FollowPlayer()
	look_at(_Player.global_position)
	self.global_position.y = 25

func _FollowPlayer():
	self.global_position.x = _Player.global_position.x +20
	self.global_position.z = _Player.global_position.z +20
