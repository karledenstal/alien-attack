extends Area2D

const SPEED = 320

func _physics_process(delta: float) -> void:
	global_position.x += SPEED * delta

func _on_visible_notifier_screen_exited() -> void:
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	queue_free()
	area.die()
