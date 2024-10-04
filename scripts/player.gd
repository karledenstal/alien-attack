extends CharacterBody2D

const SPEED = 300
const ROCKET_SCENE = preload("res://scenes/rocket.tscn")
var screen_size: Vector2

signal player_hit

func _ready() -> void:
	screen_size = get_viewport_rect().size
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(_delta: float) -> void:
	velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("move_right"):
		velocity.x = SPEED
	if Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("move_up"):
		velocity.y = -SPEED
	if Input.is_action_pressed("move_down"):
		velocity.y = SPEED
	
	global_position = global_position.clamp(Vector2(0, 0), screen_size)
	
	move_and_slide()

func shoot() -> void:
	if not $CooldownTimer.is_stopped():
		return
		
	$CooldownTimer.start()
	
	var instance = ROCKET_SCENE.instantiate()
	$RocketContainer.add_child(instance)
	instance.global_position = global_position
	instance.global_position.x += 80
	$RocketShotSound.play()
	
func take_damage():
	player_hit.emit()
	
func die():
	queue_free()
