extends Node3D
class_name Weapon

@export_range(1, 1200,0.1) var Firerate : float
@export var MagazineSize: int = 30
@export var Proyectile: PackedScene

@onready var _AudioPlayer : AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var _Muzzle : Marker3D = $Muzzle
@onready var _CooldownTimer : Timer = $Timer
@onready var _Ejection : Marker3D = $Ejection
var _AnimationPlayer : WeaponAnimationPlayer

var Ammo: int
var _CanFire: bool = true

func _ready():
	_SetFirerate()
	_AnimationPlayer = $FNX45_MODEL/CustomAnimationPlayer

func TryFire(direction: Vector3):
	if _CooldownTimer.is_stopped() and _CanFire:
		_Fire(direction)
		Ammo -= 1

@warning_ignore("unused_parameter")
func _Fire(direction: Vector3):
	_InstanceAudio()
	_PlayAnimation()
	
	_CooldownTimer.start()

#---------------------------------------------------------------------------------------------------
@warning_ignore("unused_parameter")
func _FireProjectile(direction: Vector3):
	ErrorHandlerUtil.LogWarning("OTB#004")

func _InstanceAudio():
	var new_audio_player = _AudioPlayer.duplicate()
	self.add_child(new_audio_player)
	new_audio_player.global_position = _Muzzle.global_position
	new_audio_player.pitch_scale += randf_range(-0.07,0.07)
	new_audio_player.playing = true

func _PlayAnimation():
	if not _AnimationPlayer:
		ErrorHandlerUtil.LogError("OTB#005")
		return
	
	_AnimationPlayer.PlayFireAnimation()
#---------------------------------------------------------------------------------------------------
func OnFireRelease():
	print("teamo")

func _SetFirerate():
	_CooldownTimer.wait_time=(60/Firerate)
