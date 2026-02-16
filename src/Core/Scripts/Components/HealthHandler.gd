extends Node
class_name HealthHandler

signal healed(ammount: float, changed_by: Node)
signal damaged(ammount: float, changed_by: Node)
signal died(killer: Node)

@export var MaxHealth: float = 100.0
var CurrentHealth: float

#-------------------------------------------------------------------------------
func _ready():
	CurrentHealth = MaxHealth
#Funciones Publicas-------------------------------------------------------------
func ApplyDamage(ammount: float, source: Node) -> void:
	CurrentHealth -= _CalculateDamage(ammount)
	
	if (CurrentHealth <= 0):
		emit_signal("died", source)
	
	emit_signal("damaged", ammount, source)

func Heal(ammount: float, source: Node) -> void:
	CurrentHealth += _CalculateHeal(ammount)
	emit_signal("healed", ammount, source)

#Funciones privadas-------------------------------------------------------------
func _CalculateHeal(ammount: float) -> float:
	return ammount;

func _CalculateDamage(ammount: float) -> float:
	return ammount;
