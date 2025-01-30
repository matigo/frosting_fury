extends Area2D

@onready var manager = get_node("/root/Game/CanvasLayer/ColorRect/GameManager")

func _ready() -> void:
	manager.add_donut()

func _physics_process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("found_donut"):
		manager.add_bullets(500)
		manager.sub_donut()
		body.found_donut()
		queue_free()
