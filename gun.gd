extends Area2D

var manager = false

func _ready() -> void:
	manager = get_node("/root/Game/CanvasLayer/ColorRect/GameManager")
	
func _physics_process(_delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)
		
func shoot() -> void:
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation
	%ShootingPoint.add_child(new_bullet)
	manager.sub_bullets(1)

func _on_timer_timeout() -> void:
	if manager.get_bullets() > 0:
		shoot()
