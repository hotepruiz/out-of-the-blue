extends Weapon
class_name SemiAutoWeapon

func TryFire(direction: Vector3):
	super(direction)
	_CanFire = false

func OnFireRelease():
	_CanFire = true
