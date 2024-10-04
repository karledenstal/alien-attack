extends Area2D

@export var speed = 300
signal died(scoreable: bool)

func _physics_process(delta: float) -> void:
	global_position.x -= speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func die(should_score = true):
	died.emit(should_score)
	queue_free()


func _on_body_entered(player: Node2D) -> void:
	player.take_damage()
	var scoreable = false
	die(scoreable)
