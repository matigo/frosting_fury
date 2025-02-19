extends CharacterBody2D

signal health_depleted

@onready var timer_gun = get_node("/root/Game/Player/Gun/BulletTimer")

var health: float = 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600
	move_and_slide()

	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()

	# Check if there is damage to be recorded
	const DAMAGE_RATE = 5
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health

	# If the player is no longer healthy, show the end screen
	if health <= 0:
		health_depleted.emit()

	# Check if the Player is trying to shoot or not
	if Input.is_action_just_pressed("shoot"):
		timer_gun.start()
		timer_gun.paused = false
	
	if Input.is_action_just_released("shoot"):
		timer_gun.paused = true

func found_donut() -> void:
	pass
