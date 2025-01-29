extends Node2D

@onready var manager = get_node("/root/Game/CanvasLayer/ColorRect/GameManager")

const MAX_CAKES:int = 50

func spawn_mob() -> void:
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout() -> void:
	var cakes:int = manager.get_cakes()
	if cakes <= MAX_CAKES:
		spawn_mob()

func _on_player_health_depleted() -> void:
	%GameOver.visible = true
	get_tree().paused = true
