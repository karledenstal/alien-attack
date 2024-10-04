extends Node2D

const ENEMY_SCENE = preload("res://scenes/enemy.tscn")
const PATH_ENEMY_SCENE = preload("res://scenes/path_enemy.tscn")
signal enemy_spawn(enemy_instance)
signal path_enemy_spawn(path_enemy_instance)

func _on_timer_timeout() -> void:
	spawn_enemy()

func spawn_enemy():
	var spawn_positions = $SpawnPositions.get_children()
	var random_position = spawn_positions.pick_random()
	var ins = ENEMY_SCENE.instantiate()
	ins.global_position = random_position.global_position
	enemy_spawn.emit(ins)


func _on_path_spawn_timer_timeout() -> void:
	spawn_path_enemy()

func spawn_path_enemy():
	var path_enemy_instance = PATH_ENEMY_SCENE.instantiate()
	path_enemy_spawn.emit(path_enemy_instance)
