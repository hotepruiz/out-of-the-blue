extends Node3D
class_name Weapon

signal fired

@export var magazine_size: int = 30
@export var fire_rate: float = 0.1
@export var projectile_scene: PackedScene

var ammo: int
var can_fire := true

func TryFire(direction: Vector3):
	if not can_fire or ammo <= 0:
		return
	
	ammo -= 1
	can_fire = false
	
	_Fire(direction)
	emit_signal("fired")
	
	await get_tree().create_timer(fire_rate).timeout
	can_fire = true

func _Fire(direction: Vector3):
	_FireProjectile(direction)

func _FireProjectile(direction: Vector3):
	var p = projectile_scene.instantiate()
	get_tree().current_scene.add_child(p)
	p.global_position = $Muzzle.global_position
	p.init(direction)
