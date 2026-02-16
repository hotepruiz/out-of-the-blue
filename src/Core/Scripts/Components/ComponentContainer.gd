extends Node
class_name ComponentContainer

@onready var _Children 

func _ready():
	_ValidateComponents()
	
	_Children = self.get_children()

func _ValidateComponents():
	var components = get_children()
	
	if components.is_empty():
		ErrorHandlerUtil.LogWarning("OTB#003")

func GetInteractionHandlerOrNull():
	for node in _Children:
		if node is InteractionHandler:
			return node
	
	return null;
