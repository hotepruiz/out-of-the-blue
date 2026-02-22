extends Weapon
class_name SemiAutoWeapon

func TryFire(direction: Vector3):
	if _CanFire and _TriggerPressed:
		_Fire(direction)
		_CanFire = false;

func SetTrigger(new_trigger_status: bool):
	super(new_trigger_status)
	
	if new_trigger_status == false:
		_CanFire = true
