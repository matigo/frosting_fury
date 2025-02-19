extends CharacterBody2D

@onready var manager = get_node("/root/Game/CanvasLayer/ColorRect/GameManager")
@onready var player = get_node("/root/Game/Player")

var health = 3;

func _ready() -> void:
	%Slime.play_walk()
	manager.add_cake()

func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage() -> void:
	%Slime.play_hurt()
	manager.add_point(1)
	health -= 1

	if health <= 0:
		queue_free()
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		manager.add_kill()
