extends Node
class_name InputSystem

# Señales digitales
signal fire_pressed
signal fire_released
signal interact
signal reload_pressed
signal jump_pressed
signal drop_pressed

# Señales analógicas
signal move_input(direction: Vector2)
signal look_input(delta: Vector2)

var InputEnabled := true

func _unhandled_input(event):
	if not InputEnabled:
		return
	
	# BOTONES
	if event.is_action_pressed("fire"):
		emit_signal("fire_pressed")
	if event.is_action_released("fire"):
		emit_signal("fire_released")
	if event.is_action_pressed("interact"):
		emit_signal("interact")
	#
	#if event.is_action_pressed("interact"):
		#emit_signal("interact_pressed")
	#
	#if event.is_action_pressed("reload"):
		#emit_signal("reload_pressed")
	#
	#if event.is_action_pressed("jump"):
		#emit_signal("jump_pressed")
	#
	#if event.is_action_pressed("drop_item"):
		#emit_signal("drop_pressed")


func _process(_delta):
	if not InputEnabled:
		emit_signal("move_input", Vector2.ZERO)
		return
	
	if Input.is_action_pressed("fire"):
		emit_signal("fire_pressed")
	
	var dir := Vector2.ZERO
	dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	dir.y = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	
	emit_signal("move_input", dir.normalized())


func _input(event):
	if event is InputEventMouseMotion and InputEnabled:
		emit_signal("look_input", event.relative)
