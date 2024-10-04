extends Node2D

var lives = 3
var score = 0

@onready var hud = $UI/HUD

const GAME_OVER_SCENE = preload("res://scenes/game_over.tscn")

func _ready():
	hud.set_score_label(score)

func _on_death_zone_area_entered(area: Area2D) -> void:
	area.die(false)

func _on_player_player_hit() -> void:
	lives -= 1
	hud.remove_lives(lives)
	$PlayerDamagedSound.play()
	
	if lives == 0:
		$Music.stop()
		$Player.die()
		
		$GameOverSound.play()
		
		await get_tree().create_timer(1.0).timeout
		
		var game_over_instance = GAME_OVER_SCENE.instantiate()
		game_over_instance.set_score(score)
		$UI.add_child(game_over_instance)

func _on_enemy_spawner_enemy_spawn(enemy_instance: Variant) -> void:
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)

func _on_enemy_died(scoreable: bool):
	if scoreable:
		score += 100
		hud.set_score_label(score)
		$EnemyHitSound.play()


func _on_enemy_spawner_path_enemy_spawn(path_enemy_instance: Variant) -> void:
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
