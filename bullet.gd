extends Area2D

@onready var manager = get_node("/root/Game/CanvasLayer/ColorRect/GameManager")

const RANGE: int = 1500
const SPEED: int = 1000

var travelled_distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta

	if travelled_distance <= 0:
		manager.add_shot()
		
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		manager.sub_point(1)
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
		
