extends Camera3D

var _InputSystem: InputSystem;
var _Player : Player
var _RaycastResult

func _ready() -> void:
	_Player = get_parent()._Player
	_InputSystem = get_parent()._InputSystem
	_SetupCamera()
	_ConnectToInputSystem()

func _process(float) -> void:
	_SetupCamera()
	_Raycast()

func _SetupCamera():
	look_at(_Player.global_position)

#-------------------------------------------------------------------------------
func _ConnectToInputSystem():
	_InputSystem.interact.connect(_TryInteract)

#-------------------------------------------------------------------------------
func _Raycast():
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	var origin: Vector3 = project_ray_origin(mouse_position)
	var destination: Vector3 = origin + project_ray_normal(mouse_position) * 500
	
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(origin, destination)
	
	_RaycastResult = space_state.intersect_ray(query)

func _TryInteract():
	if _RaycastResult == null:
		return
	
	var raycast_object = _RaycastResult["collider"]
	if raycast_object == null:
		return
	
	var component_container : ComponentContainer = raycast_object.get_node_or_null("ComponentContainer")
	if component_container == null:
		return
	
	var interaction_handler : InteractionHandler = component_container.GetInteractionHandlerOrNull()
	if interaction_handler:
		interaction_handler.Interact(self)
