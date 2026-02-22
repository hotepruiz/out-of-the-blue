extends Node
class_name InteractionHandler

@warning_ignore("unused_signal")
signal InteractionFailed(interacted_by: Node)
signal Interacted(interacted_by: Node)

@export var Enabled: bool = true
@export var OneShot: bool = false
@export var Cooldown: float = 0.0 

@warning_ignore("unused_private_class_variable")
@onready var _HandlerOwner = get_parent().get_parent()

var _last_interaction_time: float = -INF
var _already_used: bool = false

func Interact(interacted_by: Node) -> void:
	if not _CanInteract():
		emit_signal("interaction_failed", interacted_by)
		return
	
	_last_interaction_time = Time.get_ticks_msec() / 1000.0
	
	if OneShot:
		_already_used = true
	
	_OnInteract(interacted_by)
	emit_signal("Interacted", interacted_by)

@warning_ignore("unused_parameter")
func _OnInteract(interacted_by: Node) -> void:
	ErrorHandlerUtil.LogWarning("OTB#002")

func _CanInteract() -> bool:
	if not Enabled:
		return false
	
	if OneShot and _already_used:
		return false
	
	if Cooldown > 0:
		var current_time = Time.get_ticks_msec() / 1000.0
		if current_time - _last_interaction_time < Cooldown:
			return false
	
	return true
