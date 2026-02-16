extends CharacterBody3D
class_name Player

@export var _InputSystem: InputSystem;
@export var _Camera : CameraRig

@export var Speed: float = 6.0
@export var Acceleration: float = 10.0
@export var Friction: float = 12.0
@export var Gravity: float = 20.0

func _ready():
	_ConnectToInputSystem(_InputSystem)

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	if not is_on_floor():
		velocity.y -= Gravity * delta
	
	move_and_slide()
#---------------------------------------------------------------------------------------------------
func _ConnectToInputSystem(input_system: InputSystem):
	input_system.fire_pressed.connect(_OnFirePressed)
	input_system.move_input.connect(_OnMovement)

func _OnFirePressed():
	pass

func _OnMovement(dir: Vector2):
	if _Camera == null:
		return
	
	# Direcciones relativas, forwards siempre va a depender de donde este seteada la camara
	var forward = _GetForwardDirection().normalized()
	var right = _GetRightDirection().normalized()
	
	var target_velocity = (right * dir.x + forward * dir.y) * Speed
	
	# Movimiento suave (aceleración y fricción)
	velocity.x = lerp(velocity.x, target_velocity.x, Acceleration * get_physics_process_delta_time())
	velocity.z = lerp(velocity.z, target_velocity.y, Acceleration * get_physics_process_delta_time())
	
	move_and_slide()

#---------------------------------------------------------------------------------------------------
func _GetForwardDirection() -> Vector2:
	var forward3D = _Camera.global_transform.basis.z
	forward3D.y = 0
	return Vector2(forward3D.x, forward3D.z).normalized()

func _GetRightDirection() -> Vector2:
	var right3D = _Camera.global_transform.basis.x
	right3D.y = 0
	return Vector2(right3D.x, right3D.z).normalized()
