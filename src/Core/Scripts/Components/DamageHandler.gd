extends Node
class_name DamageHandler

signal damaged(by: Node)

func ReceiveDamage(ammount: float, by: Node):
	var health_handler := NodeUtils.GetFirstChildOfType(get_parent(), "HealthHandler") as HealthHandler
	
	if(health_handler): #Se le puede hacer daño
		var damage := _CalculateDamage(ammount)
		health_handler.ApplyDamage(damage, by)
	
	emit_signal("damaged", by)

func _CalculateDamage(base_ammount: float) -> float:
	return base_ammount;
