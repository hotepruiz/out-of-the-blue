extends InteractionHandler
class_name PickableWeaponInteractionHandler

#La idea de este InteractionHandler es que se autilizado solamente por armas, para que puedan ser utilizadas por un jugador
@onready var _ParentWeapon := _HandlerOwner as Weapon

func _OnInteract(interacted_by: Node) -> void:
	var player := interacted_by as Player
	
	if player and _ParentWeapon:
		_ParentWeapon.reparent(player.PrimaryWeaponSocket, false)
		_ParentWeapon.global_transform = player.PrimaryWeaponSocket.global_transform
		player.fire_weapon.connect(_ParentWeapon.TryFire)
	return
